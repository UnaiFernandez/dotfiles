local utils = require('utils')
require "paq" {
    "savq/paq-nvim";                  -- Let Paq manage itself

    "neovim/nvim-lspconfig";          -- Mind the semi-colons
    "onsails/lspkind-nvim";
    "nvim-treesitter/nvim-treesitter";
    "nvim-lualine/lualine.nvim";

    -- autocomplete
    "hrsh7th/nvim-cmp";
    "hrsh7th/cmp-nvim-lsp";
    "hrsh7th/cmp-buffer";
    "hrsh7th/cmp-path";   
	

    -- theme
    "navarasu/onedark.nvim";
    "romgrk/barbar.nvim";
    "kyazdani42/nvim-web-devicons";
    "yamatsum/nvim-nonicons"
}

local cmp = require'cmp'
local lspkind = require('lspkind')

cmp.setup({
    formatting = {
        format = lspkind.cmp_format(),
    },
    snippet = {
        expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For luasnip users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For ultisnips users.
        -- require'snippy'.expand_snippet(args.body) -- For snippy users.
        end,
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
        --['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<C-e>'] = cmp.mapping.close(),
        -- ['<C-y>'] = cmp.config.disable, -- If you want to remove the default <C-y> mapping, You can specify cmp.config.disable value.
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    },
    {
        { name = 'buffer' },
        { name = 'path' },
    })
})

local lsp = require 'lspconfig'

vim.diagnostic.config({
    virtual_text = {
        prefix = '■', -- Could be '●', '▎', 'x'
    }
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--lsp.rust_analyzer.setup{capabilities=capabilities}
--lsp.jedi_language_server.setup{capabilities=capabilities}
--lsp.clangd.setup{capabilities=capabilities}


-- Load lspkind package
require('lspkind').init({})
-- Execute theme
vim.cmd[[
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " `bg` will not be styled since there is no `bg` setting
  augroup END
endif
hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256
]]
require('onedark').load()
require('onedark').setup  {
    -- Main options --
    style = 'cool', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    -- toggle theme style ---
    toggle_style_key = '<leader>ts', -- Default keybinding to toggle
    toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'bold',
        strings = 'none',
        variables = 'none'
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = true, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- Treeseeter
local ts = require 'nvim-treesitter.configs'
ts.setup {
    ensure_installed = 'maintained',
    highlight = {enable = true}
}

vim.cmd[[
"Ctr-D to switch from vim to terminal and from terminal to vim
noremap <C-d> :sh<CR>
"Move through tabs with ctrl-l and ctrl-h
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>
" TagBar, show code functions and variables, really nice
nmap <F8> :TagbarToggle<CR>
" TAB in general mode will move to text buffer
nnoremap <TAB> :bnext<CR>
" " SHIFT-TAB will go back
nnoremap <S-TAB> :bprevious<CR>

" autocompletions
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap [ []<Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i

]]

vim.cmd[[
set mouse=a
set nu " Turn on line numbers
syntax on
set background=dark
syntax enable
" In insert mode, change cursor
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" Set indentation (Tab space) lenght, comment line for default
set softtabstop=4 shiftwidth=4 noexpandtab
set smartindent
set autoindent
]]

local map = utils.map
local opt = utils.opt
--local indent = 4
--
local fn = vim.fn    -- to call Vim functions e.g. fn.bufnr()

-- set gui options
if fn.has('termguicolors') == 1 then
    opt('o', 'guifont', 'Hack Regular:h18')
    opt('o', 'termguicolors', true)
end
    

map('n', '<C-d>', ':tabe term://bash<CR>:startinsert<CR>')
map('t', '<Esc>', '<C-\\><C-n>')

-- Move through tabs with ctrl-l and ctrl-h
map('n', '<C-h>', ':tabprevious<CR>')
map('n', '<C-l>', ':tabnext<CR>')

-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-c>', '<cmd>noh<CR>')    -- Clear highlights

