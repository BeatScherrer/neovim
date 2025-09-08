-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "debugBreakpoint" })
vim.fn.sign_define("DapStopped", { text = "󰐎", texthl = "debugBreakpoint" })

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

    -- NOTE: To install
    --git clone https://github.com/microsoft/vscode-js-debug ~/.local/share/nvim/vscode-js-debug
    -- cd ~/.local/share/nvim/vscode-js-debug
    -- npm install
    -- npm run compile
    "mxsdev/nvim-dap-vscode-js",
  },
  -- stylua: ignore start
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue (F5)" },
    { "<F5>", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into (F11)" },
    { "<F11>", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out (F12)" },
    { "<F12>", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over (F10)" },
    { "<F10>", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause (F6)" },
    { "<F6>", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate (S-F5)" },
    { "<S-F5>", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },

  },
  -- stylua: ignore end
  config = function()
    local dap = require("dap")
    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "/home/beat/.vscode/extensions/ms-vscode.cpptools-1.24.2-linux-x64/debugAdapters/bin/OpenDebugAD7",
      options = {
        detached = false,
      },
    }
    dap.adapters.gdb = {
      type = "executable",
      command = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
    }
    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      command = "/home/beat/.local/share/nvim/mason/bin/codelldb", -- adjust as needed, must be absolute path
      args = { "--port", "${port}" },
    }
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb-dap-20", -- adjust as needed, must be absolute path
      name = "lldb",
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
        name = "lldb coredump",
        type = "lldb",
        request = "launch",
        miDebuggerPath = "lldb-dap-20",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = false,
        coreDumpPath = function()
          return vim.fn.split(vim.fn.input("Arguments: "), " ", true)
        end,
      },
      {
        name = "lldb launch",
        type = "lldb",
        request = "launch",
        miDebuggerPath = "lldb-dap-20",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
          return vim.fn.split(vim.fn.input("Arguments: "), " ", true)
        end,
        runInTerminal = false,
      },
      {
        name = "lldb attach",
        type = "lldb",
        request = "attach",
        miDebuggerPath = "lldb-dap-20",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/live_env/bin/service/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
          return vim.fn.split(vim.fn.input("Arguments: "), " ", true)
        end,
      },
      {
        name = "lldb attach remote",
        type = "lldb",
        request = "attach",
        miDebuggerPath = "/usr/bin/lldb-dap-20",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/live_env/bin/service/", "file")
        end,
        attachCommands = {
          "gdb-remote robot-201.mt-robot.com:1234",
        },
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
          return vim.fn.split(vim.fn.input("Arguments: "), " ", true)
        end,
      },
      {
        name = "lldb coredump",
        type = "lldb",
        request = "launch",
        miDebuggerPath = "/usr/bin/lldb-dap-20",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/build/", "path")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        runInTerminal = false,
      },
    }

    dap.configurations.typescript = {
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch Chrome against localhost",
        url = "http://localhost:4200", -- Angular default port
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        runtimeExecutable = "/usr/bin/google-chrome", -- adjust for your OS
        skipFiles = { "<node_internals>/**" },
      },
      {
        type = "pwa-chrome",
        request = "launch",
        name = "Launch chrome for aquila",
        url = "http://localhost:1420", -- Angular default port
        webRoot = "${workspaceFolder}",
        sourceMaps = true,
        protocol = "inspector",
        runtimeExecutable = "/usr/bin/google-chrome", -- adjust for your OS
        skipFiles = { "<node_internals>/**" },
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
