-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- 取消自动注释续航
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- 在主题加载后设置自定义高亮
local C = require("colors.color1")
local function apply_custom_highlights()
  -- 💠 设置透明补全菜单
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" }) -- 所有浮窗透明
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", blend = 0 }) -- 补全菜单透明
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = C.pink, fg = C.surface0, bold = true }) -- 选中项
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = C.ice_white, bg = "NONE" }) -- 边框保留

  vim.api.nvim_set_hl(0, "CurSearch", {
    bg = C.mint_cream,
    fg = C.surface0,
    bold = true,
  }) -- 搜索当前项

  -- ✨ Visual 模式选中区域
  -- vim.api.nvim_set_hl(0, "Visual", {
  --   bg = C.pink,
  --   fg = C.surface0,
  --   bold = true,
  -- })
end

-- 应用高亮
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_custom_highlights,
})
