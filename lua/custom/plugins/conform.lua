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
-- vim: ts=2 sts=2 sw=2 et
