-- Set the comment string of cpp to always use //
vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function()
    vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  end,
})
