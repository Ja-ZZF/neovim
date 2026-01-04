return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        hidden = true,
        prompt_prefix = "🔎 ",
        selection_caret = "➤ ",
        entry_prefix = "  ",
        initial_mode = "insert",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.6, results_width = 0.6 },
        },
        color_devicons = true,
        dynamic_preview_title = true,
        path_display = { "smart" },

        -- ⭐ 在这里添加过滤规则
        file_ignore_patterns = {
          "node_modules",
          ".git",

          -- 二进制文件
          "%.o$",
          "%.a$",
          "%.so$",
          "%.out$",
          "%.elf$",
          "%.bin$",
          "%.hex$",
          "%.exe$",
          "%.dll$",

          -- 虚拟机/中间语言
          "%.class$",
          "%.pyc$",

          -- 构建目录
          "build/",
          "dist/",
          "target/",
          "__pycache__/",
        },
      },
    })
  end,
}
