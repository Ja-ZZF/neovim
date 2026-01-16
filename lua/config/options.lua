-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Catppuccin Macchiato Palette
local C = {
  surface0 = "#363a4f",
  surface1 = "#494d64",
  surface2 = "#5b6078",
  overlay0 = "#6e738d",
  overlay1 = "#8087a2",
  overlay2 = "#939ab7",
  lavender = "#b7bdf8",
  blue = "#8aadf4",
  sapphire = "#7dc4e4",
  sky = "#91d7e3",
  teal = "#8bd5ca",
  green = "#a6da95",
  yellow = "#eed49f",
  peach = "#f5a97f",
  maroon = "#ee99a0",
  red = "#ed8796",
  pink = "#f5bde6",
  flamingo = "#f0c6c6",
  rosewater = "#f4dbd6",
}

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.swapfile = false
vim.opt.mouse = "a"
vim.opt.laststatus = 3

-- 禁止自动注释续行
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- 防止插件重新加回来（特别是 LazyVim）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

vim.opt.cursorline = true -- 开启光标行高亮（可以只高亮行号）
vim.opt.cursorlineopt = "number" -- 只高亮行号，而不是整行

-- 全局 LSP 诊断配置
vim.diagnostic.config({
  signs = false, -- ❌ 左侧 gutter 不显示 E/W
  -- underline = true, -- 保留下划线标记
  -- virtual_text = true, -- 保留行内提示文字
  -- update_in_insert = false, -- 插入模式不更新（可选）
})

-- 创建 :H 命令，在新 tab 中打开帮助
vim.api.nvim_create_user_command("Hv", function(opts)
  vim.cmd("vertical help " .. (opts.args ~= "" and opts.args or ""))
end, { nargs = "*", complete = "help" })

vim.o.modeline = false

-- 添加 '-' 词语
vim.opt.iskeyword:append("-")
