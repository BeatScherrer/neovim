vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

return {
  { -- Autoformat
    "stevearc/conform.nvim",
    lazy = false,
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = false })
        end,
        mode = { "n", "v" },
        desc = "[C]ode [f]ormat buffer",
      },
      -- {
      --   "<leader>cfi",
      --   function()
      --     require("conform").format({ async = true, lsp_fallback = false, formatters = { "injected " } })
      --   end,
      --   mode = { "n", "v" },
      --   desc = "[C]ode [f]ormat [i]njected languages",
      -- },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        cpp = { "clang-format" },
        c = { "clang-format" },
        lua = { "stylua" },
        rust = { "rustfmt" },
        nix = { "nixfmt" },
        typescriptreact = { "biome" },
        typescript = { "biome" },
        json = { "prettier" },
        html = { "prettier" },
        python = { "pyright" },
        sh = { "mt_shfmt" },
        bash = { "mt_shfmt" },
      },
      formatters = {
        mt_shfmt = {
          command = "shfmt",
          args = { "-i", "2" },
        },
      },
    },
  },
}
