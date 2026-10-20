-- Run setup code right after the first screen is drawn, so it never delays startup.
return function(fn)
  if vim.v.vim_did_enter == 1 then
    vim.schedule(fn)
    return
  end
  vim.api.nvim_create_autocmd('UIEnter', {
    once = true,
    callback = function()
      vim.schedule(fn)
    end,
  })
end
