return {
  -- 状态栏
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- 语法高亮 & Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate", -- lazy.nvim 里用 build，不是 run
    opts = {
      ensure_installed = { "c", "cpp", "lua", "python", "cmake" }, -- 必装语言
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
