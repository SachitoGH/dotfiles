"""Build a context-aware toast (title line + body line) from Claude Code hook JSON on stdin."""
import json, os, re, sys

def clean(text, limit=160):
    text = re.sub(r"```.*?```", " ", text, flags=re.S)
    text = re.sub(r"[`*_#>]|\[([^\]]*)\]\([^)]*\)", lambda m: m.group(1) or "", text)
    line = next((l.strip(" -•\t") for l in text.splitlines() if l.strip(" -•\t")), "")
    return line if len(line) <= limit else line[: limit - 1].rstrip() + "…"

def tail_entries(path, size=2_000_000):
    """Transcript entries (newest first), reading only the end of the file."""
    try:
        with open(path, "rb") as f:
            f.seek(0, 2); f.seek(max(0, f.tell() - size))
            lines = f.read().decode("utf-8", "replace").splitlines()
    except OSError:
        return []
    out = []
    for l in reversed(lines):
        try: out.append(json.loads(l))
        except ValueError: pass
    return out

def blocks(entry):
    msg = entry.get("message") if entry.get("type") == "assistant" else None
    content = msg.get("content") if isinstance(msg, dict) else None
    return content if isinstance(content, list) else []

def last_text(entries):
    for e in entries:
        for b in reversed(blocks(e)):
            if b.get("type") == "text" and b.get("text", "").strip():
                return b["text"]
    return ""

def last_tool(entries):
    for e in entries:
        for b in reversed(blocks(e)):
            if b.get("type") == "tool_use":
                return b.get("name", ""), b.get("input") or {}
    return "", {}

def describe_tool(name, inp):
    if name == "AskUserQuestion":
        qs = inp.get("questions") or []
        return qs[0].get("question", "") if qs else ""
    if name == "Bash":
        return inp.get("description") or inp.get("command", "")
    for key in ("file_path", "notebook_path", "path", "url", "pattern", "query", "description", "prompt"):
        if inp.get(key):
            val = str(inp[key])
            return os.path.basename(val) if key.endswith("path") else val
    return ""

data = {}
try: data = json.load(sys.stdin)
except ValueError: pass
event, kind = data.get("hook_event_name", ""), data.get("notification_type", "")
entries = tail_entries(data.get("transcript_path", ""))

if event == "Stop":
    title = "✅ Done"
    body = clean(data.get("last_assistant_message") or last_text(entries)) or "Finished — your turn"
elif kind == "permission_prompt":
    name, inp = last_tool(entries)
    detail = clean(describe_tool(name, inp), 140)
    title = "🔐 Permission needed"
    body = f"{name}: {detail}" if name and detail else (name or data.get("message") or "Waiting for approval")
elif kind == "elicitation_dialog" or last_tool(entries)[0] == "AskUserQuestion":
    title = "❓ Question for you"
    body = clean(describe_tool(*last_tool(entries))) or data.get("message") or "Waiting for your answer"
else:
    title, body = "💬 Claude Code", data.get("message") or "Needs your attention"

print(title)
print(body.replace("\n", " "))
