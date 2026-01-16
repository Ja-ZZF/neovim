local tab_fg = "#282c34"
local tab_bg = "#61afef"

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",

  opts = {
    options = {
      -- 数字显示：none（简洁）或 ordinal（1,2,3）
      numbers = "ordinal",

      themable = true,

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

      diagnostics = "nvim_lsp",

      -- 配合侧边栏
      offsets = {
        {
          filetype = "neo-tree",
          text = "📂 Files",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },

    -- highlights = {
    --   buffer_selected = {
    --     fg = tab_fg,
    --     bg = tab_bg,
    --   },
    --
    --   numbers_selected = {
    --     fg = tab_fg,
    --     bg = tab_bg,
    --   },
    -- },
  },
}
