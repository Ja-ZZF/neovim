return {
  -- DAP 调试
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local map = vim.keymap.set
      local opts = { noremap = true, silent = true }

      -- ⚡ 断点和当前行图标
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointCondition" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected" })

      -- 高亮颜色
      vim.cmd("highlight DapBreakpoint guifg=#FF5555")
      vim.cmd("highlight DapStopped guifg=#50FA7B")
      vim.cmd("highlight DapBreakpointCondition guifg=#F1FA8C")
      vim.cmd("highlight DapBreakpointRejected guifg=#FF79C6")

      -- 💻 桌面 LLDB
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/local/bin/lldb-dap",
        name = "lldb",
      }

      -- 注册 cortex-debug 作为 DAP 适配器
      dap.adapters.cortex_debug = {
        type = "executable",
        command = "node",
        args = {
          os.getenv("HOME") .. "/.local/share/cortex-debug/dist/debugadapter.js",
        },
      }

      -- 自动检测可执行文件
      local function get_default_executable()
        local cwd = vim.fn.getcwd()
        local build = cwd .. "/build"
        local exe_candidates = vim.fn.glob(build .. "/*.elf", false, true)
        if #exe_candidates > 0 then
          return vim.fn.input("Path to executable: ", exe_candidates[1], "file")
        end
        return vim.fn.input("Path to executable: ", cwd .. "/", "file")
      end

      -- 配置调试项（以 OpenOCD + STM32 为例）
      dap.configurations.c = {
        {
          name = "Debug STM32 via OpenOCD",
          type = "cortex_debug", -- 必须与 adapter 名一致
          request = "launch",
          executable = get_default_executable, -- 替换为你的 .elf 文件路径
          cwd = "${workspaceFolder}",
          servertype = "openocd",
          configFiles = {
            "interface/stlink.cfg", -- 根据你的调试器修改
            "target/stm32f4x.cfg", -- 根据你的芯片修改
          },
          gdbPath = "gdb-multiarch", -- 👈 关键！指定 GDB 路径
          runToMain = true,
          showDevDebugOutput = true, -- 调试时开启，成功后可关闭
        },
      }
      -- C/C++ 桌面调试
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "lldb",
          request = "launch",
          program = get_default_executable,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      -- 快捷键
      map("n", "<F5>", dap.continue, opts)
      map("n", "<F10>", dap.step_over, opts)
      map("n", "<F11>", dap.step_into, opts)
      map("n", "<F12>", dap.step_out, opts)
      map("n", "<leader>b", dap.toggle_breakpoint, opts)
      map("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, opts)
      map("n", "<leader>dr", dap.repl.open, opts)
      map("n", "<leader>dl", dap.run_last, opts)
      map("n", "<leader>du", function()
        require("dapui").toggle()
      end, opts)
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = "mfussenegger/nvim-dap",
    opts = {
      icons = { expanded = "▾", collapsed = "▸" },
      layouts = {
        {
          elements = { "scopes", "breakpoints", "stacks", "watches" },
          size = 40,
          position = "right",
        },
        {
          elements = { "repl", "console" },
          size = 10,
          position = "bottom",
        },
      },
      floating = {
        max_height = 0.9,
        max_width = 0.5,
        border = "rounded",
        mappings = { close = { "q", "<Esc>" } },
      },
      controls = {
        enabled = true,
        element = "repl",
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          terminate = "■",
        },
      },
    },
    config = function()
      local dapui = require("dapui")
      dapui.setup()
      local dap = require("dap")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- 异步支持
  {
    "nvim-neotest/nvim-nio",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
