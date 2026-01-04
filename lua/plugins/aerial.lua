return -- 使用 lazy.nvim 安装示例
{
  "stevearc/aerial.nvim",
  config = function()
    require("aerial").setup({
      backends = { "lsp", "treesitter" }, -- 优先 Treesitter，回退 LSP
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        "Variable", -- 👈 添加变量
        "Constant", -- 👈 添加常量
        "Property", -- 👈 属性（如 JS/TS 中的 class 属性）
        "Field", -- 👈 字段（如 struct/class 成员）
      },

      layout = {
        resize_to_content = false,
        min_width = 0.15,
        width = 0.15,
        placement = "edge",
      },
      show_guides = true, -- 👈 启用缩进引导线（分割线）
      guide_chars = "│ ─├─└", -- 默认值，可自定义
      autojump = true,
    })
    vim.keymap.set("n", "<leader>o", "<cmd>AerialToggle!<CR>")
  end,
  -- 如果使用懒加载
  keys = { "<leader>o" },
}
