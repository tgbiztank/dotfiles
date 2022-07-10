local M = {}
-- shorten function name
local map = vim.keymap.set
-- noremap and silent
local opts = { noremap = true, silent = true }
-- remap leader key
vim.g.mapleader = "`"

M.general = {
  disable_Arrow_Keys = {
    map("", "<up>", "<nop>"), -- disable up arrow
    map("", "<down>", "<nop>"), -- disable down arrow
    map("", "<left>", "<nop>"), -- disable left arrow
    map("", "<right>", "<nop>"), -- disable right arrow

    map("i", "<up>", "<nop>"), -- disable up arrow
    map("i", "<down>", "<nop>"), -- disable down arrow
    map("i", "<left>", "<nop>"), -- disable left arrow
    map("i", "<right>", "<nop>"), -- disable right arrow
  },
  -- clear highlights
  map("i", "<ESC>", "<ESC><cmd>nohlsearch<CR>", opts), -- clear highlights in search -- for insert mode
  map("", "<ESC>", "<ESC><cmd>nohlsearch<CR>", opts), -- clear highlights

  -- navigate
  map("i", "<A-h>", "<Left>", opts),
  map("i", "<A-j>", "<Down>", opts),
  map("i", "<A-k>", "<Up>", opts),
  map("i", "<A-l>", "<Right>", opts),

  -- go to  beginning and end
  map("i", "<C-q>", "<ESC>^i", opts),
  map("i", "<C-e>", "<END>", opts),

  map("", "<C-q>", "^", opts),
  map("", "<C-e>", "<END>", opts),

  -- undo, redo
  map("i", "<C-z>", "<ESC>ua", opts),
  map("i", "<C-x>", "<cmd>:redo<CR>", opts),

  map("", "<C-z>", "u", opts),
  map("", "<C-x>", "<cmd>:redo<CR>", opts),

  -- delete one line
  map("i", "<C-u>", "<ESC>dda", opts),

  map("", "<C-u>", "dd", opts),

  -- select all, paste
  map("i", "<C-a>", "<ESC>ggVG", opts),
  map("i", "<C-v>", "<ESC>Pa", opts),

  map("", "<BS>", "x", opts),
  map("", "<C-a>", "ggVG", opts),
  map("", "<C-c>", "y", opts),
  map("n", "<C-v>", "P", opts),
  map("v", "<C-v>", "'_dP", opts),

  -- find
  map("i", "<C-f>", "<ESC>/"),

  map("", "<C-f>", "/"),

  -- v mode
-- Stay in indent mode
  map("v", "<", "<gv", opts),
  map("v", ">", ">gv", opts),
}
M.plugins = {
  -- NvimTree
  map("i", "<C-b>", "<ESC>:NvimTreeToggle<CR>", opts),
  map("", "<C-b>", ":NvimTreeToggle<CR>", opts),

-- Telescope
  map("i", "<F1>", ":Telescope find_files<CR>", opts),
  map("", "<F1>", ":Telescope find_files<CR>", opts),
  map("i", "<F13>", ":Telescope live_grep<CR>", opts),
  map("", "<F13>", ":Telescope live_grep<CR>", opts),

  -- Comment
  map("i", "<C-o>", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts),
  map("", "<C-o>", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts),
  map("x", "<C-o>", "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"),

  -- LSP
  map("", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", opts),
  map("", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts),
  map("n", "<leader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts),
  map("", "<leader>r", "<cmd>lua vim.lsp.buf.references()<CR>", opts),
  map("", "<A-s>", "<cmd>lua vim.diagnostic.open_float()<CR>", opts),
  map("", "<A-s>", "<cmd>lua vim.diagnostic.open_float()<CR>", opts),
  map("i", "<C-w>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts),
  map("", "<C-w>", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts),
  map("", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts),
map("i", "<A-d>", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts),
  map("", "<A-d>", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts),
  map("i", "<A-a>", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts),
  map("", "<A-a>", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts),
  map("i", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts),
  map("", "<F2>", "<cmd>lua vim.lsp.buf.rename()<CR>", opts),
  map("", "<leader>s", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts),
}
return M