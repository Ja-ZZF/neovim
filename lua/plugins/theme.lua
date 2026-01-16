-- plugins/theme.lua

-- 定义你想用的主题名字
-- 可选: "tokyonight" 或 "catppuccin"
local active_theme = "onedark"

-- 定义一个通用函数，用于在主题加载后设置自定义高亮
local function apply_custom_highlights()
  -- 💠 设置透明补全菜单
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" }) -- 所有浮窗透明
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", blend = 0 }) -- 补全菜单透明
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#5fbdd5", fg = "#1e1e2e", bold = true }) -- 选中项
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89dceb", bg = "NONE" }) -- 边框保留
end

-- 当主题重新加载时自动应用这些高亮
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_custom_highlights,
})

-- 定义主题配置表
local themes = {
  -- tokyonight
  tokyonight = {
    "folke/tokyonight.nvim",
    config = function()
      require("tokyonight").setup({
        style = "night", -- 可选: "storm", "night", "moon", "day"
        transparent = true,
        terminal_colors = true,
        lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },

  -- catppuccin
  catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- 可选: "latte", "frappe", "macchiato", "mocha"
        background = { light = "latte", dark = "mocha" },
        transparent_background = true,
        term_colors = true,
        styles = {
          comments = { "italic" },
          -- functions = { "bold" },
          -- keywords = { "italic" },
        },
        integrations = {
          telescope = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
        },
      })
      vim.cmd("colorscheme catppuccin")
      apply_custom_highlights()
    end,
  },

  -- gruvbox
  gruvbox = {
    "ellisonleao/gruvbox.nvim",
    config = function()
      require("gruvbox").setup({
        contrast = "medium", -- 可选: "hard", "medium", "soft"
        transparent_mode = true, -- 背景透明
      })
      vim.cmd("colorscheme gruvbox")
      apply_custom_highlights()
    end,
  },

  -- Nightfox 主题配置
  nightfox = {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          -- 背景透明（浮动窗口、侧边栏等）
          transparent = false,
          -- 设置终端颜色
          terminal_colors = true,
          -- 非激活窗口背景
          dim_inactive = false,
          -- 默认模块启用
          module_default = true,
          -- 样式设置
          styles = {
            comments = "italic",
            conditionals = "italic",
            constants = "NONE",
            functions = "bold",
            keywords = "bold,italic",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "italic",
            variables = "NONE",
          },
        },
      })

      -- 设置颜色方案
      vim.cmd("colorscheme dawnfox")
    end,
  },

  fluoromachine = {
    {
      "maxmx03/fluoromachine.nvim",
      lazy = false,
      priority = 1000,
      config = function()
        local fm = require("fluoromachine")

        fm.setup({
          glow = true,
          theme = "delta",
          transparent = true,
        })

        vim.cmd("colorscheme fluoromachine")
      end,
    },
  },

  oxocarbon = {
    "nyoom-engineering/oxocarbon.nvim",
  },

  rose_pine = {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        dim_inactive_windows = false,
        extend_background_behind_borders = true,

        enable = {
          terminal = true,
          legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
          migrations = true, -- Handle deprecated options automatically
        },
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },

  onedark = {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("onedark").setup({
        style = "darker",
        transparent = true, -- Show/hide background
        term_colors = true, -- Change terminal color as per the selected theme style
        ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
        cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

        code_style = {
          comments = "italic", -- 注释：轻、斜，弱化存在感
          keywords = "bold", -- 关键字：结构骨架，要稳
          functions = "bold", -- 函数名：重点
          strings = "italic", -- 字符串：略微区分
          variables = "none", -- 变量：保持干净
        },

        -- code_style = {
        --   comments = "italic",
        --   keywords = "none",
        --   functions = "none",
        --   strings = "italic",
        --   variables = "none",
        -- },

        lualine = {
          transparent = false, -- lualine center bar transparency
        },
      })
      require("onedark").load()
    end,
  },

  vscode = {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      require("vscode").setup({})
      vim.cmd.colorscheme("vscode")
    end,
  },

  github = {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup({})

      vim.cmd("colorscheme github_light_default")
    end,
  },

  onedarkpro = {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first

    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true,
        },

        styles = {
          types = "NONE",
          methods = "NONE",
          numbers = "NONE",
          strings = "NONE",
          comments = "italic",
          keywords = "italic",
          constants = "NONE",
          functions = "bold",
          operators = "NONE",
          variables = "NONE",
          parameters = "NONE",
          conditionals = "italic",
          virtual_text = "NONE",
        },
      })

      -- somewhere in your config:
      vim.cmd("colorscheme vaporwave")
    end,
  },
}

-- 返回当前激活的主题配置
return { themes[active_theme] }
