-- 在 lazy.nvim 中配置 header.nvim 插件
return {
  "attilarepka/header.nvim",
  opts = {
    -- 你可以在这里自定义配置
    allow_autocmds = true,
    file_name = true,
    author = "zzf-12", -- 你的名字
    project = "Gesture-Reco", -- 项目名
    date_created = true,
    date_created_fmt = "%Y-%m-%d %H:%M:%S",
    date_modified = true,
    date_modified_fmt = "%Y-%m-%d %H:%M:%S",
    line_separator = "------",
    use_block_header = true,
    copyright_text = {
      "Copyright (c) 2025 zzf-12",
      "ZZF-12",
      "All rights reserved.",
    },
    license_from_file = false,
    author_from_git = false,
  },
}
