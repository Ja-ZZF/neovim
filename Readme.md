# Neovim 配置

简约、实用的个人 Neovim 方案。

基于 `lazy.nvim` 加载，核心采用原生 `LSP`、`blink-cmp`、`snacks.nvim`，旨在保持编辑器轻快、可读、可维护。

---

## 结构说明

- `init.lua`：入口，仅加载 `lua/config/*.lua`
- `lua/config/options.lua`：Neovim 基础选项
- `lua/config/keymaps.lua`：快捷键定义
- `lua/config/autocmds.lua`：自动命令
- `lua/config/lazy.lua`：`lazy.nvim` 插件管理
- `lua/plugins/*.lua`：各功能插件模块

---

## 核心内容

- `lazy.nvim`：插件管理
- 原生 `nvim-lspconfig` + `mason.nvim`：语言服务和工具安装
- `blink-cmp`：轻量补全
- `snacks.nvim`：Picker / 通知 / UI 统一方案
- `neo-tree.nvim`：文件树
- `nvim-dap`：调试支持
- `noice.nvim`、`neo-scroll.nvim`：界面增强

---

## 使用方式

1. 将本配置放到 `~/.config/nvim`
2. 启动 Neovim
3. `lazy.nvim` 会自动安装和加载插件
4. 管理插件请使用 `:Lazy`

---

## 设计原则

- 少而精
- 以可读性为先
- 优先原生能力
- 不追求 IDE 化

---

## 依赖要求

- Neovim `>= 0.9`
- Git
- 视语言需要安装 Node / Python / C/C++ 编译链

