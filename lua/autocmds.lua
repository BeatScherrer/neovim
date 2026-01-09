-- Set the comment string of cpp to always use //
vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
  pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
  callback = function()
    vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
  end,
})

-- Replace #include "mt_xxx/yyy" with #include <xxx/yyy> on save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.cpp", "*.h", "*.hpp" },
  callback = function()
    local file = vim.fn.expand("%:p")
    vim.fn.system(string.format([[sed -i 's/#include "\(mt_.*\/.*\)"/#include <\1>/g' %s]], vim.fn.shellescape(file)))
    -- Reload the buffer if the file was modified
    vim.cmd("checktime")
  end,
})
