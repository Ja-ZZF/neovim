return {
  -- Git 集成
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- 自动括号匹配
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- 启用 Treesitter 检测语言
        enable_check_bracket_line = true, -- 同一行避免重复括号
      })

      -- 集成 nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },

  -- 一键注释
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup({
        -- 默认配置已经很方便
        toggler = {
          line = "gcc", -- 切换行注释
          block = "gbc", -- 切换块注释
        },
        opleader = {
          line = "gc", -- 可视模式操作行注释
          block = "gb", -- 可视模式操作块注释
        },
        mappings = {
          basic = true, -- 启用基本映射
          extra = true, -- gco/gcO 额外映射
        },
      })
    end,
  },
}
