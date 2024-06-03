-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
return {
  {
    "folke/tokyonight.nvim",
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme("tokyonight-night")
      -- You can configure highlights by doing something like:
      -- vim.cmd.hi("Comment gui=none")
    end,
  },
  -- FIXME: gravel pit is broken... again
  {
    -- dir = "~/src/beat/gravel-pit.nvim",
    -- init = function()
    --   vim.cmd.colorscheme("gravel_pit_dark")
    -- end,
  },
  {
    "rebelot/kanagawa.nvim",
    init = function()
      vim.cmd.colorscheme("kanagawa")
    end,
  },
}
