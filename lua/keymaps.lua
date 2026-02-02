-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize: TODO: enhance this to be dynamic. i.e. resize in the arrow direction
vim.keymap.set("n", "<C-Up>", "<cmd>horizontal resize +5<cr>", { desc = "Increase size horizontally" })
vim.keymap.set("n", "<C-Down>", "<cmd>horizontal resize -5<cr>", { desc = "Decrease size horizontally" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase size vertically" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease size vertically" })

vim.keymap.set("n", "<leader>e", "Neotree toggle", { desc = "Open Neotree" })

vim.keymap.set("n", "<A-o>", function()
  local params = { uri = vim.uri_from_bufnr(0) }
  vim.lsp.buf_request(0, "textDocument/switchSourceHeader", params, function(err, result)
    if err or not result or result == "" then
      return
    end
    vim.cmd.edit(vim.uri_to_fname(result))
  end)
end, { desc = "Switch between source/header" })

vim.api.nvim_set_keymap("c", "w!!", "w !sudo tee > /dev/null %", { noremap = true })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

vim.keymap.set("n", "<leader>mm", "<cmd>Make<cr>")

-- Tabs
vim.keymap.set("n", "<leader><Tab><Tab>", "<cmd>tabnew<cr>", { desc = "New [Tab]" })
vim.keymap.set("n", "<leader><Tab>d", "<cmd>tabc<cr>", { desc = "[d]elete tab" })
vim.keymap.set("n", "<C-PageUp>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<C-PageDown>", "<cmd>tabnext<CR>", { desc = "Next tab" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
