call plug#begin()
    " Appearance
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'ryanoasis/vim-devicons'

    " Utilities
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    Plug 'preservim/nerdtree'
    Plug 'plasticboy/vim-markdown'

    " Git
    Plug 'airblade/vim-gitgutter'
    " LSP
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/mason.nvim'
    " Treesitter
    Plug 'nvim-treesitter/nvim-treesitter'
    call plug#end()

" Normal mode remappings
nnoremap <C-q> :q!<CR>
nnoremap <F5> :NERDTreeToggle<CR>
"" Tabs
nnoremap <S-Tab> gT
nnoremap <Tab> gt
nnoremap <silent> <S-t> :tabnew<CR>

" LSP configuration
lua <<EOF
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
EOF

" Treesitter configuration
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "html", "css", "go", "lua" },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true
  }
}
EOF
" Airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Disable math tex conceal feature
let g:tex_conceal = ''
let g:vim_markdown_math = 1

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['tsx=typescriptreact']

" Options
autocmd vimenter * ++nested colorscheme gruvbox
autocmd InsertLeave * write
set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set relativenumber
set splitbelow splitright
set title
set ttimeoutlen=0
set wildmenu

" Tabs size
set expandtab
set shiftwidth=2
set tabstop=2

" Syntax
filetype plugin indent on
syntax on

" Color support
set t_Co=256
" True color if available
let term_program=$TERM_PROGRAM

if $TERM !=? 'xterm-256color'
  set termguicolors
endif

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" File browser
let g:netrw_banner=0
let g:netrw_liststyle=0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_winsize=25
let g:netrw_keepdir=0
let g:netrw_localcopydircmd='cp -r'
let NERDTreeShowHidden=1

" Create file without opening buffer
function! CreateInPreview()
  let l:filename = input('please enter filename: ')
  execute 'silent !touch ' . b:netrw_curdir.'/'.l:filename
  redraw!
endfunction

" Netrw: create file using touch instead of opening a buffer
function! Netrw_mappings()
  noremap <buffer>% :call CreateInPreview()<cr>
endfunction

augroup auto_commands
    autocmd filetype netrw call Netrw_mappings()
augroup END
