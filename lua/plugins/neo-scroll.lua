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

    -- 可选：自定义更精细的映射（覆盖默认行为）
    local neoscroll = require("neoscroll")
    local keymap = {
      ["<C-u>"] = function()
        neoscroll.ctrl_u({ duration = 300 })
      end,
      ["<C-d>"] = function()
        neoscroll.ctrl_d({ duration = 300 })
      end,
      ["<C-b>"] = function()
        neoscroll.ctrl_b({ duration = 300 })
      end,
      ["<C-f>"] = function()
        neoscroll.ctrl_f({ duration = 300 })
      end,
      ["zt"] = function()
        neoscroll.zt({ half_win_duration = 150 })
      end,
      ["zz"] = function()
        neoscroll.zz({ half_win_duration = 150 })
      end,
      ["zb"] = function()
        neoscroll.zb({ half_win_duration = 150 })
      end,
    }
    for key, fn in pairs(keymap) do
      vim.keymap.set({ "n", "v", "x" }, key, fn, { silent = true })
    end
  end,
}
