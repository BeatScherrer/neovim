return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = "claude-code",
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      enable_cursor_planning_mode = true, -- https://github.com/yetone/avante.nvim/blob/main/cursor-planning-mode.md
    },
    acp_providers = {
      ["claude-code"] = {
        command = "claude-code-acp",
        -- args = { "@zed-industries/claude-code-acp" },
        env = {
          NODE_NO_WARNINGS = "1",
          ANTHROPIC_API_KEY = os.getenv("ANTHROPIC_API_KEY"),
        },
      },
    -- ["gemini-cli"] = {
    --   command = "gemini",
    --   args = { "--experimental-acp" },
    --   env = {
    --     NODE_NO_WARNINGS = "1",
    --     GEMINI_API_KEY = os.getenv("GEMINI_API_KEY"),
    --   },
    -- },
    -- ["goose"] = {
    --   command = "goose",
    --   args = { "acp" },
    -- },
    -- ["codex"] = {
    --   command = "codex-acp",
    --   env = {
    --     NODE_NO_WARNINGS = "1",
    --     OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
    --   },
    -- },
    },
    -- rag_service = {
    --   enabled = false, -- Enables the RAG service
    --   host_mount = os.getenv("HOME"), -- Host mount path for the rag service
    --   provider = "openai", -- The provider to use for RAG service (e.g. openai or ollama)
    --   llm_model = "", -- The LLM model to use for RAG service
    --   embed_model = "", -- The embedding model to use for RAG service
    --   endpoint = "https://api.openai.com/v1", -- The API endpoint for RAG service
    -- },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      "zbirenbaum/copilot.lua",
      lazy = true,
      cmd = "Copilot",
      event = "InsertEnter",
    },
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    -- {
    --   -- Make sure to set this up properly if you have lazy=true
    --   "MeanderingProgrammer/render-markdown.nvim",
    --   opts = {
    --     file_types = { "markdown", "Avante" },
    --   },
    --   ft = { "markdown", "Avante" },
    -- },
  },
}