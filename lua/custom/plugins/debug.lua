-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  "mfussenegger/nvim-dap",
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    {
      "rcarriga/nvim-dap-ui",
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
      },
      opts = {},
      -- config = function(_, opts)
      --   local dap = require("dap")
      --   local dapui = require("dapui")
      --   dapui.setup(opts)
      --   dap.listeners.after.event_initialized["dapui_config"] = function()
      --     dapui.open({})
      --   end
      --   dap.listeners.before.event_terminated["dapui_config"] = function()
      --     dapui.close({})
      --   end
      --   dap.listeners.before.event_exited["dapui_config"] = function()
      --     dapui.close({})
      --   end
      -- end,
    },
    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",

    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },

    -- which key integration
    {
      "folke/which-key.nvim",
      optional = true,
      opts = {
        defaults = {
          ["<leader>d"] = { name = "+debug" },
          ["<leader>da"] = { name = "+adapters" },
        },
      },
    },

    -- Installs the debug adapters for you
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",

    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
  },
  -- stylua: ignore start
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<F5>", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<S-F11>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<F6>", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<S-F5>", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },
  -- stylua: ignore end
  config = function()
    local dap = require("dap")
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "/home/beat/.vscode/extensions/ms-vscode.cpptools-1.22.10-linux-x64/debugAdapters/bin/OpenDebugAD7",
      options = {
        detached = false,
      },
    }

    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "delve",
      },
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    -- dapui.setup({
    --   -- Set icons to characters that are more likely to work in every terminal.
    --   --    Feel free to remove or use ones that you like more! :)
    --   --    Don't feel like these are good choices.
    --   icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
    --   controls = {
    --     icons = {
    --       pause = "⏸",
    --       play = "▶",
    --       step_into = "⏎",
    --       step_over = "⏭",
    --       step_out = "⏮",
    --       step_back = "b",
    --       run_last = "▶▶",
    --       terminate = "⏹",
    --       disconnect = "⏏",
    --     },
    --   },
    -- })

    -- use events to open/close dapui automatically
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
      },
      {
        name = "Remote",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        cwd = vim.fn.getcwd(),
        miDebuggerServerAddress = function()
          local host = vim.fn.input("Host to debug (port 7777): ", "localhost")
          return host .. ":7777"
        end,
        miDebuggerPath = "/usr/bin/gdb",
        program = function()
          -- TODO: maybe we can attach the gdbserver on the remote as part of launching the debugger

          -- local target = "root@" .. miDebuggerServerAddress
          local executable = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
          -- os.execute("ssh -c root@" .. target .. "gdbserver --attach :7777 $(pgrep " .. executable")")
          return executable
        end,
      },
      {
        name = "Local",
        type = "cppdbg",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = function()
          return "localhost:7777"
        end,
        miDebuggerPath = "/usr/bin/gdb",
        cwd = "${workspaceFolder}",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/live_env/bin/service/", "file")
        end,
      },
    }

    -- Install golang specific config
    require("dap-go").setup({
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has("win32") == 0,
      },
    })
  end,
}
