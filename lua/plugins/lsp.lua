return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "glepnir/lspsaga.nvim",
      "folke/trouble.nvim",
      "j-hui/fidget.nvim",
    },
    config = function()
      -- =================== capabilities ===================
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- =================== on_attach ===================
      local on_attach = function(client, bufnr)
        print("✅ LSP attached: " .. client.name)

        -- 如果是 clangd，关闭其诊断
        -- if client.name == "clangd" then
        --   client.server_capabilities.documentFormattingProvider = false
        --   -- 关键：禁用该 LSP 客户端发送的诊断
        --   if client.supports_method("textDocument/publishDiagnostics") then
        --     -- 覆盖诊断处理：什么都不做
        --     vim.diagnostic.disable(bufnr)
        --   end
        -- end

        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      -- =================== C / C++ ===================
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--query-driver=/usr/bin/sdcc", -- 👈 关键！允许 clangd 查询 SDCC 的头文件
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cc" },
        root_markers = { ".clangd", "compile_commands.json", "CMakeLists.txt", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("clangd")

      -- =================== Python ===================
      -- vim.lsp.config("pyright", {
      --   cmd = { "pyright-langserver", "--stdio" },
      --   root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      --   settings = {
      --     python = {
      --       analysis = {
      --         typeCheckingMode = "basic",
      --         autoSearchPaths = true,
      --         diagnosticMode = "workspace",
      --         useLibraryCodeForTypes = true,
      --       },
      --     },
      --   },
      -- })
      -- vim.lsp.enable("pyright")

      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          python = {
            pythonPath = "./venv/bin/python", -- ⭐ 关键
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              reportAttributeAccessIssue = "none", -- ⭐ 解决 tf.keras
            },
          },
        },
      })
      vim.lsp.enable("pyright")

      -- =================== Lua ===================
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".git", "lua" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = {
                vim.fn.stdpath("config"),
                vim.fn.stdpath("data") .. "/lazy",
                vim.api.nvim_get_runtime_file("", true),
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- =================== Bash ===================
      vim.lsp.config("bashls", {
        cmd = { "bash-language-server", "start" },
        filetypes = { "sh", "bash", "make" },
        root_markers = { ".git", ".bashrc", ".zshrc", "Makefile", "Dockerfile" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("bashls")

      -- =================== HTML ===================
      vim.lsp.config("html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("html")

      -- =================== CSS ===================
      vim.lsp.config("cssls", {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("cssls")

      -- =================== JavaScript/TypeScript ===================
      vim.lsp.config("tsserver", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("tsserver")

      -- =================== lspsaga ===================
      require("lspsaga").setup({
        ui = { border = "rounded" },
        symbol_in_winbar = { enable = false },
        lightbulb = { enable = false, virtual_text = false },
      })

      -- =================== trouble ===================
      require("trouble").setup({
        win = { position = "bottom", height = 0.3 },
        icons = {
          error = "",
          warning = "",
          hint = "",
          information = "",
        },
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        action_keys = {
          close = "q",
          jump = { "<cr>", "<tab>" },
          refresh = "r",
        },
        use_diagnostic_signs = true,
      })
    end,
  },
}
