return {
  "milanglacier/minuet-ai.nvim",
  config = function()
    require("minuet").setup({
      debug = true,
      notify = "debug",
      virtualtext = {
        auto_trigger_ft = {
          "lua",
        },
        keymap = {
          -- accept whole completion
          accept = "<A-A>",
          -- accept one line
          accept_line = "<A-a>",
          -- accept n lines (prompts for number)
          accept_n_lines = "<A-z>",
          -- Cycle to prev completion item, or manually invoke completion
          prev = "<A-[>",
          -- Cycle to next completion item, or manually invoke completion
          next = "<A-]>",
          dismiss = "<A-e>",
        },
      },
      provider = "openai_fim_compatible",

      n_completions = 1, -- recommend for local model for resource saving
      -- I recommend you start with a small context window firstly, and gradually
      -- increase it based on your local computing power.
      context = {
        window = 768,
      },
      request_timeout = 5,

      provider_options = {
        -- codestral = {
        --   model = "codestral-latest",
        --   end_point = "https://codestral.mistral.ai/v1/fim/completions",
        --   api_key = "CODESTRAL_API_KEY",
        --   stream = true,
        --   template = {
        --     prompt = "See [Prompt Section for default value]",
        --     suffix = "See [Prompt Section for default value]",
        --   },
        --   optional = {
        --     stop = nil, -- the identifier to stop the completion generation
        --     max_tokens = nil,
        --   },
        -- },
        -- openai_fim_compatible = {
        --   api_key = "TERM",
        --   name = "Ollama",
        --   end_point = "http://localhost:11434/v1/completions",
        --   model = "deepseek-coder-v2",
        --   optional = {
        --     max_tokens = 256,
        --     top_p = 0.9,
        --   },
        -- },
        openai_fim_compatible = {
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://localhost:11434/v1/completions",
          model = "qwen2.5-coder:7b",
          optional = {
            max_tokens = 256,
            top_p = 0.9,
          },
        },
      },

      -- Your configuration options here
    })
  end,
}
