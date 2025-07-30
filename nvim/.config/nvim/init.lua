-- settting options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.cmdheight = 0
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 350
vim.o.timeoutlen = 400
vim.o.splitright = true
vim.o.splitbelow = true
-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.tabstop = 4
-- vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.termguicolors = true
vim.o.winborder = 'rounded'
vim.o.guicursor = ""

-- basic keymaps
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<F1>', '<Nop>')
vim.keymap.set('n', 's', '<Nop>')

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Plugins with vim-plug
local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug ('mcchrish/nnn.vim')
Plug ('tpope/vim-fugitive')
Plug ('tpope/vim-surround')
Plug ('lervag/wiki.vim')
Plug 'drsooch/gruber-darker-vim'
Plug ('folke/snacks.nvim')
Plug ('nvim-treesitter/nvim-treesitter')
Plug ('nvim-lua/plenary.nvim')
Plug ('ThePrimeagen/harpoon', { ['branch'] = 'harpoon2' })
Plug ('echasnovski/mini.completion')
Plug ('rebelot/kanagawa.nvim')
Plug ('ixru/nvim-markdown')
Plug 'nvim-lualine/lualine.nvim'
Plug ('justinmk/vim-dirvish')
Plug ('MunifTanjim/nui.nvim')

vim.call('plug#end')

vim.cmd('colorscheme GruberDarker')

-- LSP
vim.lsp.enable { 'clangd'}
require('mini.completion').setup()

-- statusline
require('lualine').setup{
    options = {
        theme = 'Tomorrow',
   }
}
vim.g.wiki_root = '~/notes'
vim.keymap.set("n", "<leader>wp", "<cmd>WikiPages<CR>")
vim.keymap.set("n", "<leader>we", "<cmd>WikiJournal<CR>")

-- file picker
require('snacks').setup({
	bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
})

-- Picker commands
-- find
vim.keymap.set("n", "<leader>fn", function() 
    Snacks.picker.files({cwd = "~/notes"})
end)

vim.keymap.set("n", "<leader>fl", function() 
    Snacks.picker.files({cwd = "~/learning"})
end)

vim.keymap.set("n", "<leader>fp", function() 
    Snacks.picker.files({cwd = "~/projects"})
end)

vim.keymap.set("n", "<leader>fj", function() 
    Snacks.picker.files({cwd = "~/notes/journal"})
end)

vim.keymap.set("n", "<leader>fm", function() 
    vim.ui.input({prompt = "Enter man page"}, function(input)
        vim.cmd('split | enew')
        vim.cmd('read !man ' .. input .. ' | col -bx')
        vim.cmd('normal! gg')
    end
    )
end)

vim.keymap.set("n", "<leader>b", function() Snacks.picker.buffers() end)
vim.keymap.set("n", "<leader>:", function() Snacks.picker.command_history() end)
vim.keymap.set("n", "<leader>fg", function() Snacks.picker.git_files() end)
-- git
vim.keymap.set("n", "<leader>gb", function() Snacks.picker.git_branches() end)
vim.keymap.set("n", "<leader>gl", function() Snacks.picker.git_log() end)
vim.keymap.set("n", "<leader>gL", function() Snacks.picker.git_log_line() end)
vim.keymap.set("n", "<leader>gs", function() Snacks.picker.git_status() end)
vim.keymap.set("n", "<leader>gd", function() Snacks.picker.git_diff() end)
vim.keymap.set("n", "<leader>gf", function() Snacks.picker.git_log_file() end)
-- grep
vim.keymap.set("n", "<leader>sb", function() Snacks.picker.lines() end) 
vim.keymap.set("n", "<leader>sof", function() Snacks.picker.grep_buffers() end) 
vim.keymap.set("n", "<leader>sg", function() Snacks.picker.grep() end)
vim.keymap.set("n", "<leader>sw", function() Snacks.picker.grep_word() end)
-- search
vim.keymap.set("n", "<leader>sk", function() Snacks.picker.keymaps() end)
vim.keymap.set("n", "<leader>sM", function() Snacks.picker.man() end)
vim.keymap.set("n", "<leader>sc", function() Snacks.picker.command_history() end)
vim.keymap.set("n", "<leader>s/", function() Snacks.picker.search_history() end)
-- lsp 
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "gt", function() vim.lsp.buf.type_definition() end)
vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end)
vim.keymap.set("n", "grr", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "<leader>le", function() vim.diagnostic.setloclist() end)
vim.keymap.set("n", "gri", function() vim.lsp.buf.implementation() end)
vim.keymap.set("n", "gra", function() vim.lsp.buf.code_action() end)

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>e", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>a", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>9", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader>0", function() harpoon:list():select(5) end)

-- Toggle previous & next buffers
vim.keymap.set("n", "1n", "<cmd>bp<CR>")
vim.keymap.set("n", "1p", "<cmd>bn<CR>")

--random
vim.keymap.set("n", "<leader>da", "ggVGc")
vim.keymap.set("n", "<leader>ca","ggVG")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>cl", "<cmd>.!tup<CR>")
vim.keymap.set("v", "<leader>cf", "<cmd>.!fup<CR>")

vim.g.vim_markdown_conceal = 2
vim.g.vim_markdown_math = 1
vim.g.vim_markdown_toc_autofit = 1

-- autopairs but not really 
vim.keymap.set("i", '"<tab>', '""<Left>')
vim.keymap.set("i", "'<tab>", "''<Left>")
vim.keymap.set("i", "(<tab>", "()<Left>")
vim.keymap.set("i", "[<tab>", "[]<Left>")
vim.keymap.set("i", "{<tab>", "{}<Left>")
vim.keymap.set("i", "<<tab>", "<><Left>")
vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>O")
vim.keymap.set("i", "`<tab>", "```c```<Left><Left><Left><CR><CR><Up>")


-- copy line with cursor position and also for header
vim.keymap.set("n", "<leader>.", function() 
	local cursor_posn = vim.fn.getpos(".")
	cursor_posn[2] = cursor_posn[2] + 1  -- Increment line number
	vim.cmd("normal! yyp")
	vim.fn.setpos(".", cursor_posn)
end)

vim.keymap.set("n", "<leader>h.", function() 
	local cursor_posn = vim.fn.getpos(".")
	cursor_posn[2] = cursor_posn[2] + 1  -- Increment line number
	vim.cmd("normal! yyp")
	vim.fn.setpos(".", cursor_posn)
	vim.cmd("normal! di<a")
	vim.cmd("startinsert")
end)

-- specific yank from line above
function Specific_yank_above(destination)
	local cursor_posn = vim.fn.getpos(".")
	local line_num = vim.fn.line(".")
	local target_line = line_num - destination
	vim.api.nvim_win_set_cursor(0, { target_line, 0 })
	vim.cmd("normal! yy")
	vim.fn.setpos(".", cursor_posn)
end
vim.keymap.set("n", "<leader>ya", ":lua Specific_yank_above()<Left>")

function Specific_yank_below(destination)
	local cursor_posn = vim.fn.getpos(".")
	local line_num = vim.fn.line(".")
	local target_line = line_num + destination
	vim.api.nvim_win_set_cursor(0, { target_line, 0 })
	vim.cmd("normal! yy")
	vim.fn.setpos(".", cursor_posn)
end
vim.keymap.set("n", "<leader>yb", ":lua Specific_yank_below()<Left>")

-- terminal
vim.keymap.set("n", '<leader>rl', "<cmd>e ~/.vim/vimrc<CR>")
vim.keymap.set('t', '<C-n>', '<C-w>w')
vim.keymap.set('n', '<leader>-', '<C-w>w')

vim.keymap.set("n", '<leader>mw', function()
	vim.cmd("lcd %:p:h")
	vim.cmd("split | enew")
	vim.cmd(".!make")
    vim.cmd("lcd -")
end)

-- specific files navigation 
vim.keymap.set("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>wv", "<cmd>e ~/.config/nvim/init.lua<CR>")
vim.keymap.set("n", "<leader>wt", "<cmd>e ~/.tmux.conf<CR>")
vim.keymap.set("n", "<leader>wb", "<cmd>e ~/.bashrc<CR>")
vim.keymap.set("n", "<leader>wj", "<cmd>e ~/imp_random/scratch.c<CR>")
vim.keymap.set("n", "<leader>wk", "<cmd>e ~/imp_random/scratch.txt<CR>")

-- location list qol
vim.keymap.set("n", "<leader>cl", "<C-w>w:q<CR>")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>")

-- file picker creater etc
vim.keymap.set("n", "<leader>n", "<cmdNnnPicker<CR>") 
