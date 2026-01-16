-- lua/plugins/noice.lua
return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim", -- 必须
  },
  config = function()
    require("noice").setup({
      -- 命令行配置
      cmdline = {
        enabled = true, -- 启用 Noice 命令行
        view = "cmdline_popup", -- 浮窗形式
        format = {
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { pattern = "^/", icon = "", lang = "regex" },
          search_up = { pattern = "^%?", icon = "", lang = "regex" },
          lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
        },
      },

      -- LSP 配置
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
        progress = { enabled = false, view = "mini" },
        hover = { enabled = false },
        signature = { enabled = false },
        message = { enabled = false, view = "notify" },
      },

      notify = {
        enabled = false,
      },

      -- 预设
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    })
  end,
}
