set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-surround'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

"telescope + dependencies
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

"colorscheme
"Plug 'Mofiqul/dracula.nvim'
Plug 'Nequo/vim-allomancer'

call plug#end()

let g:numbers_exclude = ['nerdtree']

set termguicolors
colorscheme allomancer

let g:airline_theme='solarized_flood'

set tabstop=4
set shiftwidth=4
set smarttab

set showcmd

set number
set ruler

syntax on
set hlsearch
set incsearch

"set completeopt=longest,menu
set wildmode=list:longest,list:full

set guifont=Panic\ Sans:h13
set t_Co=256

set wildignore+=.git,tmp,log,*.png,*.jpg,*.jpeg,*.gif,public/analytic,public/fonts,public/sounds,public/images,public/flash
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

set clipboard=unnamedplus

source ~/.config/nvim/coc.nvim.vim

set mouse=a

nnoremap ,n <cmd>CHADopen --always-focus<cr>
nnoremap ,m <cmd>CHADopen<cr>

nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>Telescope live_grep<cr>
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Vimtex
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

let g:vimtex_compiler_method = 'tectonic'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
autocmd! BufWritePost *.tex normal \ll

" UltiSnips

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Markdown Preview

function OpenMarkdownPreview (url)
	execute "silent ! firefox -new-window " . a:url
endfunction

let g:mkdp_auto_start = 1
let g:mkdp_browserfunc = 'OpenMarkdownPreview'

function Check()
    let l:line=getline('.')
    let l:curs=winsaveview()
    if l:line=~?'\s*-\s*\[\s*\].*'
        s/\[\s*\]/[x]/
    elseif l:line=~?'\s*-\s*\[x\].*'
        s/\[x\]/[ ]/
    endif
    call winrestview(l:curs)
endfunction

nnoremap mc :call Check()<CR>
