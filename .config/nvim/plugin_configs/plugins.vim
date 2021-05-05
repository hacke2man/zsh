" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin()

" editing
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'terryma/vim-multiple-cursors'
    Plug 'amadeus/vim-convert-color-to'

" Coc
    Plug 'neoclide/coc.nvim'
let g:coc_global_extensions = ['coc-json', 'coc-tsserver', 'coc-vimlsp',
            \  'coc-snippets', 'coc-prettier', 'coc-marketplace',
            \  'coc-gitignore', 'coc-emmet']

" laf
    Plug 'gruvbox-community/gruvbox'
    Plug 'shinchu/lightline-gruvbox.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'mhinz/vim-signify'
    Plug 'mhinz/vim-startify'
    " Plug 'ryanoasis/vim-devicons'
    Plug 'sheerun/vim-polyglot'
    Plug 'nathanaelkane/vim-indent-guides'

" movement
    Plug 'unblevable/quick-scope'

" backend?
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'airblade/vim-rooter'
    Plug 'tpope/vim-sleuth'

" idk intrusive stuff?
    Plug 'ThePrimeagen/vim-be-good'
    Plug 'junegunn/gv.vim'
    Plug 'nvim-telescope/telescope.nvim'

" info
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'szw/vim-dict'
    Plug 'ap/vim-buftabline'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
