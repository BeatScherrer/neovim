return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = "ollama",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      temperature = 0,
      max_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
    --- @type AvanteProvider
    ollama = {
      -- api_key_name = "",
      model = "codestral",
      -- parse_curl_args = function(opts, code_opts)
      --   return {
      --     url = opts.endpoint .. "/chat/completions",
      --     headers = {
      --       ["Accept"] = "application/json",
      --       ["Content-Type"] = "application/json",
      --       ["x-api-key"] = "ollama",
      --     },
      --     body = {
      --       model = opts.model,
      --       -- TODO:
      --       messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
      --       max_tokeans = 2048,
      --       stream = true,
      --     },
      --   }
      -- end,
      -- parse_response_data = function(data_stream, event_state, opts)
      --   require("avante.providers").openai.parse_response(data_stream, event_state, opts)
      -- end,
    },
    behaviour = {
      auto_suggestions = false, -- Experimental stage
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
      enable_cursor_planning_mode = true, -- https://github.com/yetone/avante.nvim/blob/main/cursor-planning-mode.md
    },
    rag_service = {
      enabled = false, -- Enables the RAG service
      host_mount = os.getenv("HOME"), -- Host mount path for the rag service
      provider = "openai", -- The provider to use for RAG service (e.g. openai or ollama)
      llm_model = "", -- The LLM model to use for RAG service
      embed_model = "", -- The embedding model to use for RAG service
      endpoint = "https://api.openai.com/v1", -- The API endpoint for RAG service
    },
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
    "zbirenbaum/copilot.lua", -- for providers='copilot'
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
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
