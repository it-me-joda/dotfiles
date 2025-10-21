vim.cmd([[
set clipboard=unnamedplus
set number
set relativenumber
set cursorline
set noshowmode
set colorcolumn=80
set tabstop=4
set shiftwidth=0
]])

vim.o.wrap = false

local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
  vim.cmd('silent !curl -fLo ' .. data_dir .. '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  vim.o.runtimepath = vim.o.runtimepath
  vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('catppuccin/nvim', { as = 'catppuccin' })
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'cohama/lexima.vim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'puremourning/vimspector'
Plug 'voldikss/vim-floaterm'
Plug 'nvim-lua/plenary.nvim'
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'itchyny/lightline.vim'
Plug 'RRethy/vim-illuminate'
Plug 'smoka7/hop.nvim'
Plug 'habamax/vim-godot'
Plug 'github/copilot.vim'
Plug 'folke/which-key.nvim'
Plug 'airblade/vim-gitgutter'
Plug 'VPavliashvili/json-nvim'
Plug 'Lommix/bevy_inspector.nvim'
vim.call('plug#end')

require('ibl').setup()

require('telescope').setup({
  defaults = {
	file_ignore_patterns = {"node_modules", ".git/"},
	},
})

require('mason').setup()
require('mason-lspconfig').setup()

require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  hidden = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.opt.completeopt = {'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

require('lspconfig').gdscript.setup({
	on_attach = on_attach,
	flags = {
		debounce_text_changes=10,
	}
	
})

require('rust-tools').setup()
require('bevy_inspector').setup()

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

require('nvim-tree').setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 22,
	},
	renderer = {
		group_empty = true,
	},
})

local hop = require('hop')
hop.setup({
	keys = 'aoeuidhtns'
})

local directions = require('hop.hint').HintDirection

require('catppuccin').setup({
	flavour = "mocha",
	background = {
		light = "latte",
		dark = "mocha",
	},
	transparent_background = true,
	show_end_of_buffer = false,
	dim_inactive = {
		enabled = false,
		shade = "dark",
		percentage = 0.15,
	},
})

vim.cmd.colorscheme 'catppuccin'
vim.g.lightline = {
	colorscheme = "catppuccin"
}

function map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function vmap(shortcut, command)
	map('v', shortcut, command)
end

function nmap(shortcut, command)
	map('n', shortcut, command)
end

function imap(shortcut, command)
	map('i', shortcut, command)
end

function tmap(shortcut, command)
	map('t', shortcut, command)
end

nmap('<C-S>', '<Cmd>w<CR>')
nmap('<C-S-Up>', '<Cmd>m -2<CR>')
nmap('<C-S-Down>', '<Cmd>m +1<CR>')
nmap('<C-W>a', '<C-W><Left>')
nmap('<C-W>o', '<C-W><Down>')
nmap('<C-W>e', '<C-W><Right>')
nmap('<C-W>,', '<C-W><Up>')
nmap('<A-Left>', '<C-W><Left>')
nmap('<A-Right>', '<C-W><Right>')
nmap('<A-Up>', '<C-W><Up>')
nmap('<A-Down>', '<C-W><Down>')

imap('<C-g>', '<Plug>(copilot-suggest)')

nmap('h', '<Cmd>HopWord<CR>')
nmap('<C-h>', '<Cmd>HopChar2<CR>')

nmap('<C-P>', '<Cmd>Telescope find_files theme=dropdown hidden=true<CR>')

nmap('<C-F><C-T>', '<Cmd>FloatermNew --name=float --autoclose=2 zsh <CR>')
nmap('t', '<Cmd>FloatermToggle float<CR>')
tmap('<Esc>', '<C-\\><C-n>:q<CR>')

tmap('<A-t>', '<C-\\><C-n>:q<CR>')

nmap('<C-b>', '<Cmd>NvimTreeToggle<CR>')

nmap('<F9>', '<Cmd>call vimspector#Launch()<CR>')
nmap('<F5>', '<Cmd>call vimspector#StepOver()<CR>')
nmap('<F8>', '<Cmd>call vimspector#Reset()<CR>')
nmap('<F11>', '<Cmd>call vimspector#StepOver()<CR>')
nmap('<F12>', '<Cmd>call vimspector#StepOut()<CR>')
nmap('<F10>', '<Cmd>call vimspector#StepInto()<CR>')
nmap('grd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
nmap('grD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
nmap('grh', '<Cmd>lua vim.lsp.buf.hover()<CR>')

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

vim.cmd([[
let g:vimspector_sidebar_width = 85
let g:vimspector_bottombar_height = 15
let g:vimspector_terminal_maxwidth = 70
let g:godot_executable = "flatpak run org.godotengine.GodotSharp"
]])

if vim.g.neovide then
	vim.g.neovide_opacity = 1.0
	vim.g.neovide_refresh_rate = 120
	vim.g.neovide_idle_refresh_rate = 5

	local positionAnimationLength = 0.0
	local scrollAnimationFarLines = 0.0
    local scrollAnimationLength = 0.0
    vim.g.neovide_position_animation_length = positionAnimationLength
    vim.g.neovide_scroll_animation_far_lines = scrollAnimationFarLines
    vim.g.neovide_scroll_animation_length = scrollAnimationLength

    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function(args)
            local filetype = vim.api.nvim_buf_get_option(args.buf, "filetype")

           -- When entering terminal for first time I noticed the filetype is empty
            if filetype == '' or filetype == 'terminal' then
                vim.g.neovide_position_animation_length = 0
                vim.g.neovide_scroll_animation_far_lines = 0
                vim.g.neovide_scroll_animation_length = 0
            else
                vim.g.neovide_position_animation_length = positionAnimationLength
                vim.g.neovide_scroll_animation_far_lines = scrollAnimationFarLines
                vim.g.neovide_scroll_animation_length = scrollAnimationLength
            end
        end,
    })
end
