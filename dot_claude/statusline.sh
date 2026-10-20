#!/usr/bin/env bash
# Claude Code status line (adapts to terminal width):
#   󰚩 Opus 5.5 󰧑 high │  sachito │  ━━╸━━━ 38% │ 󰔟 ━╸━━━━ 28% 󰦛 2h23 │  ━━━━━━ 33% 󰦛 2d7h │ 1.42
# Everything comes from the stdin JSON; only the USD→EUR rate is fetched (once a day, cached).
# Width comes from $COLUMNS (set by Claude Code), falling back to tput.
COLUMNS="${COLUMNS:-$(tput cols 2>/dev/null)}" exec python3 -I -c '
import json, os, re, sys, time, urllib.request

try:
    d = json.load(sys.stdin)
except Exception:
    d = {}

def get(*path):
    cur = d
    for p in path:
        if not isinstance(cur, dict):
            return None
        cur = cur.get(p)
    return cur

RST = "\033[0m"
def c(code, s): return f"\033[{code}m{s}{RST}"
DIM = "38;5;244"

def level(p):  # green → yellow → orange → red
    return "38;5;114" if p < 50 else "38;5;221" if p < 75 else "38;5;208" if p < 90 else "38;5;203"

def gauge(p, width):  # thin line bar with half-cell precision: ━━━╸──
    p = max(0, min(100, p))
    halves = round(p / 100 * width * 2)
    full, half = divmod(halves, 2)
    bar = c(level(p), "━" * full + ("╸" if half else ""))
    return bar + c("38;5;238", "━" * (width - full - half))

def until(ts):
    s = int(ts - time.time())
    if s <= 0: return "now"
    m, h, dd = s // 60 % 60, s // 3600 % 24, s // 86400
    if dd: return f"{dd}d{h}h" if h else f"{dd}d"
    if h:  return f"{h}h{m:02d}"
    return f"{m}m"

def eur_rate():
    cache = os.path.expanduser("~/.claude/cache/usd_eur.json")
    try:
        with open(cache) as f: j = json.load(f)
        if time.time() - j["t"] < 86400: return j["r"]
    except Exception:
        j = None
    try:
        with urllib.request.urlopen("https://api.frankfurter.app/latest?from=USD&to=EUR", timeout=1.5) as r:
            rate = json.load(r)["rates"]["EUR"]
        os.makedirs(os.path.dirname(cache), exist_ok=True)
        with open(cache, "w") as f: json.dump({"t": time.time(), "r": rate}, f)
        return rate
    except Exception:
        return j["r"] if j else 0.92

# ---- data ----
model = (get("model", "display_name") or "Claude").replace("Claude ", "")
m = re.match(r"(\w)\w*\s+([\d.]+)", model)
model_short = m.group(1) + m.group(2) if m else model.split()[0]
effort = get("effort", "level")
effort = str(effort).lower() if effort else None
effort_short = {"medium": "med", "xhigh": "xhi"}.get(effort, effort)
# project_dir = where Claude was launched; current_dir follows any cd done during the session
cwd = get("workspace", "project_dir") or get("workspace", "current_dir") or d.get("cwd") or os.getcwd()
name = "~" if os.path.abspath(cwd) == os.path.expanduser("~") else os.path.basename(cwd.rstrip("/")) or "/"
ctx = get("context_window", "used_percentage")
limits = [(get("rate_limits", k, "used_percentage"), get("rate_limits", k, "resets_at"), icon)
          for k, icon in (("five_hour", "\U000f051f"), ("seven_day", ""))]
usd = get("cost", "total_cost_usd")

# ---- render with a given compaction level ----
# Each step drops the least useful detail first; stop at the first one that fits.
STEPS = ["full", "bar4", "short", "noprice", "nobar", "no7dreset", "noicons", "tightsep", "nodir", "noeffort", "no7d"]

def render(n):
    on = set(STEPS[1:n + 1])
    bar_w = 0 if "nobar" in on else 4 if "bar4" in on else 6
    icon = lambda s: "" if "noicons" in on else s + " "
    parts = []

    seg = c("38;5;111", icon("\U000f06a9")) + c("1;38;5;111", model_short if "short" in on else model)
    if effort and "noeffort" not in on:
        seg += " " + c("38;5;213", icon("\U000f09d1") + (effort_short if "short" in on else effort))
    parts.append(seg)

    if "nodir" not in on:
        parts.append(c("38;5;180", icon("")) + c("1;38;5;180", name))

    def meter(p, ic):
        s = c(DIM, ic + " ")  # quota icons stay: they are the only label
        if bar_w: s += gauge(p, bar_w) + " "
        return s + c(level(p), f"{p:.0f}%")

    if ctx is not None:
        parts.append(meter(ctx, ""))
    for i, (p, r, ic) in enumerate(limits):
        if p is None or (i == 1 and "no7d" in on): continue
        seg = meter(p, ic)
        if r and not (i == 1 and "no7dreset" in on):
            seg += " " + c(DIM, "\U000f099b " + until(r))
        parts.append(seg)

    if usd is not None and "noprice" not in on:
        parts.append(c("38;5;242", f"{usd * eur_rate():.2f} "))

    return c("38;5;236", " " if "tightsep" in on else " │ ").join(parts)

visible = lambda s: len(re.sub(r"\033\[[0-9;]*m", "", s))
try:
    cols = int(os.environ.get("COLUMNS", "")) - 4  # Claude Code pads the status line
except ValueError:
    cols = 10**6
for n in range(len(STEPS)):
    out = render(n)
    if visible(out) <= cols:
        break
sys.stdout.write(out)
'
