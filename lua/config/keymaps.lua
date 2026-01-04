-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- lua/keymaps.lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- leader 键
vim.g.mapleader = " " -- 空格为 leader

-- ===============================
-- NvimTree 文件树
-- ===============================
-- map("n", "<leader>e", ":NvimTreeToggle<CR>", opts) -- 打开/关闭文件树
-- map("n", "<leader>r", ":NvimTreeRefresh<CR>", opts) -- 刷新文件树

-- 下一个 / 上一个 Tab
map("n", "<leader><PageDown>", ":BufferLineCycleNext<CR>", opts) -- 下一个 Tab
map("n", "<leader><PageUp>", ":BufferLineCyclePrev<CR>", opts) -- 上一个 Tab

-- 快速跳转到指定 Tab（1~9）
for i = 1, 9 do
  map("n", "<leader>" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", opts)
end

-- 关闭当前 Tab
map("n", "<leader>c", ":bdelete!<CR>", opts)

-- ===============================
-- 分屏操作
-- ===============================
-- map("n", "<leader>v", ":vsplit<CR>", opts) -- 垂直分屏
-- map("n", "<leader>s", ":split<CR>", opts) -- 水平分屏
map("n", "<leader><Left>", "<C-w>h", opts) -- 移动到左边窗口
map("n", "<leader><Down>", "<C-w>j", opts) -- 移动到下边窗口
map("n", "<leader><Up>", "<C-w>k", opts) -- 移动到上边窗口
map("n", "<leader><Right>", "<C-w>l", opts) -- 移动到右边窗口

-- ===============================
-- 文件操作
-- ===============================
map("n", "<leader>w", ":w<CR>", opts) -- 保存
map("n", "<leader>q", ":q<CR>", opts) -- 关闭

-- ===============================
-- Telescope 搜索（模糊查找）
-- 需要安装 telescope.nvim
-- ===============================
map("n", "<leader>ff", ":Telescope find_files<CR>", opts) -- 搜索文件 -- 基于项目路径
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts) -- grep 搜索 -- 基于项目路径
map("n", "<leader>fb", ":Telescope buffers<CR>", opts) -- 切换 buffer
map("n", "<leader>fh", ":Telescope help_tags<CR>", opts) -- 查帮助文档
map("n", "<leader>rf", ":Telescope oldfiles<CR>", opts) -- 查询近期文件
vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>", { desc = "Find References" })

-- 搜索后按 Enter 跳到下一个匹配
vim.keymap.set("n", "<CR>", "n", { noremap = true, silent = true })

-- 在终端模式中按 Esc 直接退出到普通模式
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- ===============================
-- 底部终端
-- ===============================
--[[ map("n", "<leader>t", ":botright 10split | terminal<CR>i", opts) -- 打开底部终端并进入插入模式 ]]

-- 可选：兼容终端中使用 Ctrl+C（仅在 GUI 中安全，终端中慎用）
vim.keymap.set("v", "<C-c>", [["+y]], { noremap = true, silent = true })
vim.keymap.set("n", "<C-c>", [["+yy]], { noremap = true, silent = true })

-- 剪切到系统剪贴板
vim.keymap.set("v", "<C-x>", [["+d]], { noremap = true, silent = true }) -- 可视模式剪切
vim.keymap.set("n", "<C-x>", [["+dd]], { noremap = true, silent = true }) -- 普通模式剪切整行

-- 黏贴到当前光标位置
vim.keymap.set("n", "<C-v>", [["+p]], { noremap = true, silent = true })
vim.keymap.set("v", "<C-v>", [["+p]], { noremap = true, silent = true })

-- ===============================
-- 文本选择与跳转
-- ===============================
-- 将 vv 映射为 v%，快速选中到匹配的括号/标签
-- 例如：光标在 { 上按 vv，会选中从 { 到 } 的整个块
map("n", "vv", "v%", opts)
map("n", "vc", "viw", opts)
map("n", "vl", "V", opts)

-- ===============================
-- 搜索操作
-- ===============================
map("n", "<leader><space>", ":let @/=''<CR>:noh<CR>", opts) -- 清除搜索高亮

-- -- 载入 cmake_build 模块
-- local cmake = require("keymaps.cmake_build")
--
-- -- 绑定 F6/F7
-- map("n", "<F6>", cmake.configure, opts)
-- map("n", "<F7>", cmake.build, opts)
-- map("n", "<F8>", cmake.run, opts)

local float_term = {}

float_term.term_buf = nil
float_term.term_win = nil
float_term.term_chan = nil

local float_width = 0.75
local float_height = 0.75

-- 打开或复用浮窗终端
function float_term.open()
  if float_term.term_buf and vim.api.nvim_buf_is_valid(float_term.term_buf) then
    if float_term.term_win and vim.api.nvim_win_is_valid(float_term.term_win) then
      vim.api.nvim_set_current_win(float_term.term_win)
    else
      -- 重新创建窗口
      local width = math.floor(vim.o.columns * float_width)
      local height = math.floor(vim.o.lines * float_height)
      local row = math.floor((vim.o.lines - height) / 2)
      local col = math.floor((vim.o.columns - width) / 2)
      float_term.term_win = vim.api.nvim_open_win(float_term.term_buf, true, {
        style = "minimal",
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "rounded",
      })
    end
    vim.cmd("startinsert")
    return float_term.term_chan
  end

  -- 创建新的 buffer
  float_term.term_buf = vim.api.nvim_create_buf(false, true)

  local width = math.floor(vim.o.columns * float_width)
  local height = math.floor(vim.o.lines * float_height)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  float_term.term_win = vim.api.nvim_open_win(float_term.term_buf, true, {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  })

  -- Linux 使用 zsh 打开交互终端
  float_term.term_chan = vim.fn.termopen({ "zsh", "-i" }, { detach = 0 })

  vim.cmd("startinsert")

  return float_term.term_chan
end

-- 发送命令到浮窗终端
function float_term.send(cmd)
  local chan = float_term.open()
  vim.fn.chansend(chan, cmd .. "\n")
end

-- 清空浮窗终端
function float_term.clear()
  if float_term.term_buf and vim.api.nvim_buf_is_valid(float_term.term_buf) then
    vim.api.nvim_buf_set_lines(float_term.term_buf, 0, -1, false, {})
  end
end

local cmake_build = {}

local project_root = vim.fn.getcwd() -- 当前项目根目录
local build_dir = project_root .. "/build"

local clang_executable = "/usr/local/bin/clang" -- Clang 编译器路径
local clangxx_executable = "/usr/local/bin/clang++" -- Clang++ 编译器路径

-- 复用 terminal
local term_buf = nil
local term_chan = nil

-- 在浮窗终端执行命令，并可自动打开日志
local function run_in_float_terminal(cmd, log_file)
  -- 打开浮窗终端
  --[[ local chan = term_module.open() ]]

  -- 进入插入模式
  --[[ vim.cmd("startinsert") ]]

  -- 发送命令
  -- vim.fn.chansend(chan, cmd .. "\r")
  float_term.send(cmd)
  -- 退出插入模式
  vim.cmd("stopinsert")
  -- 可选：显示日志文件
  -- if log_file then
  --     vim.defer_fn(function()
  --         if vim.fn.filereadable(log_file) == 1 then
  --             vim.cmd("edit " .. log_file)
  --             vim.cmd("normal! G")
  --         end
  --     end, 1200)
  -- end
end

-- F6: 配置 CMake 项目
function cmake_build.configure()
  if vim.fn.isdirectory(build_dir) == 0 then
    vim.fn.mkdir(build_dir)
    print("Created build directory: " .. build_dir)
  end

  -- 配置 CMake 的命令
  local cmd = string.format(
    'cd "%s" && cmake .. -G Ninja -DCMAKE_C_COMPILER="%s" -DCMAKE_CXX_COMPILER="%s" -DCMAKE_EXPORT_COMPILE_COMMANDS=ON',
    build_dir,
    clang_executable,
    clangxx_executable
  )

  run_in_float_terminal(cmd, build_dir .. "/cmake_configure.log")
end

-- F7: 编译项目
function cmake_build.build()
  if vim.fn.isdirectory(build_dir) == 0 then
    print("Build directory does not exist. Please configure the project with F6 first.")
    return
  end

  -- 编译项目，并输出日志到 cmake_build.log
  local cmd = string.format('cd "%s" && cmake --build . --parallel --config Debug > cmake_build.log 2>&1', build_dir)

  run_in_float_terminal(cmd, build_dir .. "/cmake_build.log")
end

-- F8: 运行项目
function cmake_build.run()
  local cmd = string.format(
    'cd "%s" && ./*',
    build_dir .. "/bin" -- 假设编译出的可执行文件是 .out 文件
  )

  run_in_float_terminal(cmd, build_dir .. "/run_output.log")
end

--
-- 打开一个弹窗
map("n", "<leader>ft", float_term.open, opts)

-- 绑定 F6/F7
map("n", "<F6>", cmake_build.configure, opts)
map("n", "<F7>", cmake_build.build, opts)
map("n", "<F8>", cmake_build.run, opts)

--
-- -- 打开智能聊天
-- local chat = require("keymaps.float_chat")
-- map("n", "<leader>sc", chat.start_chat, opts)
--
-- 打开诊断窗口
vim.keymap.set("n", "<leader>xx", ":Trouble diagnostics toggle<CR>", opts)
--
-- 在你的配置中绑定快捷键
-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })
--
-- 让 ]] 的行为更智能（使用 matchit）
vim.keymap.set("n", "]]", ":normal! ]m<CR>", opts)
vim.keymap.set("n", "[[", ":normal! [m<CR>", opts)

-- 在你的 keymaps.lua 中添加
vim.keymap.set("v", "<Tab>", ">", { noremap = true, silent = true })
vim.keymap.set("v", "<S-Tab>", "<", { noremap = true, silent = true }) -- Shift+Tab 减少缩进

vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

-- 设置显示 / 不显示 tab
vim.keymap.set("n", "<leader>tb", function()
  if vim.o.showtabline == 0 then
    vim.o.showtabline = 2
  else
    vim.o.showtabline = 0
  end
end, { desc = "Toggle Bufferline" })
