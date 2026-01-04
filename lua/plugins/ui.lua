return {
  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- 顶部 tab
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        -- 数字显示：none（简洁）或 ordinal（1,2,3）
        numbers = "ordinal",

        -- 关闭 buffer 的命令
        -- bufferline setup 内的 options 部分
        close_command = function(bufnr)
          -- 获取所有 buffer（仅限已列出并没有被隐藏的）
          local buffers = vim.tbl_filter(function(b)
            return vim.api.nvim_buf_get_option(b.bufnr, "buftype") == ""
              and vim.api.nvim_buf_get_option(b.bufnr, "buflisted")
          end, vim.fn.getbufinfo({ buflisted = 1 }))

          -- 如果有多个 buffer，删除当前 buffer
          if #buffers > 1 then
            vim.cmd("bdelete! " .. bufnr)
          else
            -- 如果只有一个 buffer，创建一个空 buffer
            vim.cmd("enew")
          end
        end,

        right_mouse_command = function(bufnr)
          local buffers = vim.tbl_filter(function(b)
            return vim.api.nvim_buf_get_option(b.bufnr, "buftype") == ""
              and vim.api.nvim_buf_get_option(b.bufnr, "buflisted")
          end, vim.fn.getbufinfo({ buflisted = 1 }))

          if #buffers > 1 then
            vim.cmd("bdelete! " .. bufnr)
          else
            vim.cmd("enew")
          end
        end,

        -- 左键切换 buffer 保持原来的方式
        left_mouse_command = "buffer %d",

        -- 中键可以禁用
        middle_mouse_command = nil,

        -- 图标设置
        indicator_icon = "",
        buffer_close_icon = "✖",
        close_icon = "", -- 更柔和的关闭图标
        modified_icon = "●",
        show_buffer_close_icons = false,
        show_close_icon = false, -- 右上角大关闭按钮

        -- 分隔符样式：推荐 "thin" 或 "slant"
        separator_style = "thin", -- 也可以试试 "slant"

        -- 始终显示 tabline
        always_show_bufferline = true,

        -- tab 宽度
        tab_size = 16,

        -- 是否显示 tab 编号
        show_tab_indicators = false,

        -- 配合侧边栏
        offsets = {
          {
            filetype = "neo-tree",
            text = "📂 Files",
            highlight = "Directory",
            text_align = "left",
          },
        },

        -- 🌟 启用 LSP 诊断
        diagnostics = "nvim_lsp",
      },

      -- highlights = {
      --   -- 🔲 所有背景设为透明
      --   fill = { bg = "none" },
      --   background = { bg = "none" },
      --   tab = { bg = "none" },
      --   tab_selected = { bg = "none", bold = true },
      --   tab_separator = { bg = "none" },
      --   tab_separator_selected = { bg = "none" },
      --   tab_close = { bg = "none" },
      --
      --   close_button = { bg = "none" },
      --   close_button_visible = { bg = "none" },
      --   close_button_selected = { bg = "none" },
      --
      --   buffer_visible = { bg = "none" },
      --   buffer_selected = { bg = "none", bold = true, italic = true },
      --   -- buffer_selected = { bg = "#F07178", fg = "#FFFFFF", bold = true, italic = true },
      --
      --   numbers = { bg = "none" },
      --   numbers_visible = { bg = "none" },
      --   numbers_selected = { bg = "none", bold = true },
      --
      --   diagnostic = { bg = "none" },
      --   diagnostic_visible = { bg = "none" },
      --   diagnostic_selected = { bg = "none" },
      --
      --   hint = { bg = "none" },
      --   hint_visible = { bg = "none" },
      --   hint_selected = { bg = "none" },
      --
      --   info = { bg = "none" },
      --   info_visible = { bg = "none" },
      --   info_selected = { bg = "none" },
      --
      --   warning = { bg = "none" },
      --   warning_visible = { bg = "none" },
      --   warning_selected = { bg = "none" },
      --
      --   error = { bg = "none" },
      --   error_visible = { bg = "none" },
      --   error_selected = { bg = "none" },
      --
      --   modified = { bg = "none" },
      --   modified_visible = { bg = "none" },
      --   modified_selected = { bg = "none" },
      --
      --   duplicate = { bg = "none" },
      --   duplicate_visible = { bg = "none" },
      --   duplicate_selected = { bg = "none" },
      --
      --   separator = { bg = "none" },
      --   separator_visible = { bg = "none" },
      --   separator_selected = { bg = "none" },
      --
      --   indicator_visible = { bg = "none" },
      --   indicator_selected = { bg = "none" },
      --
      --   pick = { bg = "none" },
      --   pick_visible = { bg = "none" },
      --   pick_selected = { bg = "none" },
      --
      --   offset_separator = { bg = "none" },
      --   trunc_marker = { bg = "none" },
      -- },
    },
  },

  -- 确保 snacks.nvim 插件先加载
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = true },
    },
  },

  -- 缩进线
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "BufRead", -- 使用 BufRead 事件代替 LazyFile
  --   opts = function()
  --     Snacks.toggle({
  --       name = "Indention Guides",
  --       get = function()
  --         return require("ibl.config").get_config(0).enabled
  --       end,
  --       set = function(state)
  --         require("ibl").setup_buffer(0, { enabled = state })
  --       end,
  --     }):map("<leader>ug")
  --
  --     return {
  --       indent = {
  --         char = "│",
  --         tab_char = "│",
  --       },
  --       scope = { show_start = false, show_end = false },
  --       exclude = {
  --         filetypes = {
  --           "Trouble",
  --           "alpha",
  --           "dashboard",
  --           "help",
  --           "lazy",
  --           "mason",
  --           "neo-tree",
  --           "notify",
  --           "snacks_dashboard",
  --           "snacks_notif",
  --           "snacks_terminal",
  --           "snacks_win",
  --           "toggleterm",
  --           "trouble",
  --         },
  --       },
  --     }
  --   end,
  --   main = "ibl",
  -- },

  -- 语法高亮 & Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate", -- lazy.nvim 里用 build，不是 run
    opts = {
      ensure_installed = { "c", "cpp", "lua", "python" }, -- 必装语言
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = true },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },
}
