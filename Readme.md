# Neovim Configuration

> 🧠 A modern, fast, and opinionated Neovim setup  
> 基于 **LSP + blink-cmp + snacks.nvim** 的现代化 Neovim 个人配置

---

## ✨ Features | 特性

- 🚀 **Fast startup** – 基于 `lazy.nvim` 的按需加载
- 🧩 **LSP-centric** – 以原生 LSP 为核心，而非 IDE 模拟
- ⚡ **blink-cmp** – 极速、简洁的补全体验
- 🍿 **snacks.nvim** – Picker / UI / Notifier 一体化方案
- 🎨 **Clean UI** – 克制、透明、可读性优先
- 🛠 **Highly modular** – 插件按功能拆分，易维护

---

## 🧱 Core Architecture | 核心架构

### 🔹 LSP (Language Server Protocol)

- 使用 **Neovim 内置 LSP**
- `mason.nvim` 负责 LSP / Formatter / DAP 管理
- `lsp.lua` 统一配置：
  - capabilities
  - keymaps
  - diagnostics
  - inlay hints
  - server-specific settings

> 目标：**让编辑器理解代码，而不是堆插件**

---

### 🔹 Completion – blink-cmp

- 使用 [`blink-cmp`](https://github.com/Saghen/blink.cmp)
- 替代传统 `nvim-cmp`
- 特点：
  - 更快
  - 更少魔法
  - 更清晰的 source 管理

配置文件：
```

lua/plugins/blink-cmp.lua

```

---

### 🔹 UI / Picker – snacks.nvim

- 使用 [`folke/snacks.nvim`](https://github.com/folke/snacks.nvim)
- 替代：
  - telescope
  - notify
  - 部分 UI 插件

主要功能：
- Picker（文件 / LSP / Git）
- Notifier
- Indent / UI enhancements

配置文件：
```

lua/plugins/snacks.lua

````

---

## 📁 Directory Structure | 目录结构

```text
.
├── init.lua                 # 入口
├── lazyvim.json             # lazy.nvim 相关配置
├── lazy-lock.json           # 插件锁定文件
├── stylua.toml              # Lua 格式化配置
├── lua/
│   ├── config/              # 基础配置（options / keymaps / autocmd）
│   └── plugins/             # 插件模块
│       ├── lsp.lua
│       ├── blink-cmp.lua
│       ├── snacks.lua
│       ├── dap.lua
│       ├── ui.lua
│       ├── theme.lua
│       ├── formatter.lua
│       └── ...
└── README.md
````

---

## 🔌 Plugins Overview | 插件概览

| Category    | Plugin                         |
| ----------- | ------------------------------ |
| LSP         | `nvim-lspconfig`, `mason.nvim` |
| Completion  | `blink-cmp`                    |
| UI / Picker | `snacks.nvim`                  |
| File Tree   | `neo-tree.nvim`                |
| Debug       | `nvim-dap`                     |
| Syntax      | `nvim-treesitter`              |
| Formatting  | `conform.nvim` / formatter     |
| Git         | 内置 + snacks picker             |

---

## ⌨️ Key Philosophy | 设计理念

* **Less but better**
  少即是多，但留下的必须是精品
* **Readable > Fancy**
  可读性优先于炫技
* **Native first**
  优先使用 Neovim 原生能力
* **No IDE cosplay**
  不把 Neovim 变成 VSCode

---

## 🖥 Requirements | 环境要求

* Neovim **≥ 0.9 / 0.10**
* Git
* Node / Python / C/C++ toolchain（视语言而定）

---

## 🚧 Status | 状态

* 持续演进中
* 偏向 **个人生产力配置**
* 不保证向后兼容

---


## 🙋 Notes

This configuration is **opinionated**.
Steal whatever you like, ignore the rest.

这是一份**有明确取舍的配置**，
不是“什么都要”的大杂烩。

