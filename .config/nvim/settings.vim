" Nvim settings

filetype plugin on
syntax on
set nowrap
set relativenumber
set nu
set colorcolumn=+80
hi ColorColumn ctermbg=darkgray
set scrolloff=8
set sidescrolloff=10
set signcolumn=yes

set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab

set clipboard+=unnamedplus
set incsearch
set foldmethod=syntax
set foldlevelstart=100
set wildmenu
set wildignore+=/home/liam/**/node_modules/**
set wildignore+=/home/liam/**/plugged/**
set matchpairs+=':'

set splitbelow
set splitright

set noswapfile
set visualbell
set cursorline
" complete
" completeopt
" fileformats
" guifont, guifontset

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

set listchars=trail:~,extends:>,precedes:<,tab:>-
set list
set fillchars=fold:\ 
set termguicolors
