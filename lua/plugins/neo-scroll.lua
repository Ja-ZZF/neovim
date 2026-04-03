return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy", -- 或 "BufReadPost"，按需触发
  opts = {
    -- 启用默认映射（可选）
    mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
    hide_cursor = true, -- 滚动时隐藏光标
    stop_eof = true, -- 到达文件末尾时停止
    respect_scrolloff = false,
    cursor_scrolls_alone = true,
    easing = "quadratic", -- 更自然的滚动效果
    performance_mode = false, -- 如遇卡顿可设为 true
    pre_hook = nil,
    post_hook = nil,
  },
  config = function(_, opts)
    require("neoscroll").setup(opts)
  end,
}

-- return {}
