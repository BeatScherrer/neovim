-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require("which-key").setup()

      -- Document existing key chains
      require("which-key").add({
        { "<leader><Tab>", group = "[T]ab" },
        { "<leader><Tab>_", hidden = true },
        { "<leader>a", group = "[A]ction" },
        { "<leader>c", group = "[C]ode" },
        { "<leader>c_", hidden = true },
        { "<leader>d", group = "[D]ocument" },
        { "<leader>d_", hidden = true },
        { "<leader>h", group = "Git [H]unk" },
        { "<leader>f", group = "[F]ind" },
        { "<leader>g", group = "[G]it" },
        { "<leader>m", group = "[M]ake" },
        { "<leader>h_", hidden = true },
        { "<leader>r", group = "[R]ename" },
        { "<leader>r_", hidden = true },
        { "<leader>s", group = "[S]earch" },
        { "<leader>s_", hidden = true },
        { "<leader>t", group = "[T]oggle" },
        { "<leader>t_", hidden = true },
        { "<leader>u", group = "[U]ser Interface" },
        { "<leader>u_", hidden = true },
        { "<leader>un", group = "[N]oice" },
        { "<leader>un_", hidden = true },
        { "<leader>w", group = "[W]orkspace" },
        { "<leader>w_", hidden = true },
        { "<leader>x", group = "Todo" },
      })
      -- visual mode
      require("which-key").add({
        { "<leader>h", desc = "Git [H]unk", mode = "v" },
      }, { mode = "v" })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
