-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

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

-- 自定义 aerial 高亮（建议放在 colorscheme 加载之后）
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*",
--   callback = function()
--     -- 函数
--     vim.api.nvim_set_hl(0, "AerialFunction", { link = "Function" })
--     vim.api.nvim_set_hl(0, "AerialFunctionIcon", { fg = "#FF79C6", bold = true })
--
--     -- 类
--     vim.api.nvim_set_hl(0, "AerialClass", { link = "Type" })
--     vim.api.nvim_set_hl(0, "AerialClassIcon", { fg = "#8BE9FD", bold = true })
--
--     -- 方法
--     vim.api.nvim_set_hl(0, "AerialMethod", { link = "Function" })
--     vim.api.nvim_set_hl(0, "AerialMethodIcon", { fg = "#50FA7B", bold = true })
--
--     -- 变量 / 常量
--     vim.api.nvim_set_hl(0, "AerialVariable", { link = "Identifier" })
--     vim.api.nvim_set_hl(0, "AerialConstant", { link = "Constant" })
--     vim.api.nvim_set_hl(0, "AerialVariableIcon", { fg = "#F1FA8C" })
--     vim.api.nvim_set_hl(0, "AerialConstantIcon", { fg = "#BD93F9" })
--
--     -- 接口、结构体等
--     vim.api.nvim_set_hl(0, "AerialInterface", { link = "Type" })
--     vim.api.nvim_set_hl(0, "AerialStruct", { link = "Type" })
--     vim.api.nvim_set_hl(0, "AerialInterfaceIcon", { fg = "#FFB86C" })
--     vim.api.nvim_set_hl(0, "AerialStructIcon", { fg = "#FFB86C" })
--
--     -- 枚举
--     vim.api.nvim_set_hl(0, "AerialEnum", { link = "Type" })
--     vim.api.nvim_set_hl(0, "AerialEnumIcon", { fg = "#FF79C6" })
--
--     -- 模块
--     vim.api.nvim_set_hl(0, "AerialModule", { link = "Include" })
--     vim.api.nvim_set_hl(0, "AerialModuleIcon", { fg = "#8BE9FD" })
--
--     -- 构造函数
--     vim.api.nvim_set_hl(0, "AerialConstructor", { link = "Special" })
--     vim.api.nvim_set_hl(0, "AerialConstructorIcon", { fg = "#FF5555" })
--
--     -- 通用 fallback
--     vim.api.nvim_set_hl(0, "AerialNormal", { link = "Normal" })
--
--     -- 当前行高亮（类似 QuickFixLine）
--     vim.api.nvim_set_hl(0, "AerialLine", { link = "QuickFixLine" })
--
--     -- 非当前窗口的行（可选）
--     vim.api.nvim_set_hl(0, "AerialLineNC", { bg = "#44475a" }) -- 根据你的配色调整
--
--     -- 树形引导线（如果你启用了 show_guides）
--     vim.api.nvim_set_hl(0, "AerialGuide", { fg = "#6272a4", italic = true })
--   end,
-- })

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
