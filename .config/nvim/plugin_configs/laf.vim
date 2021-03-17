"colorscheme plug
colorscheme gruvbox

" indent guide plug
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  guibg=bg
let g:indent_guides_exclude_filetypes = ['startify', 'vim', 'floaterm', 'help', 'no ft', 'man', 'mail']

let g:buftabline_indicators = 1

" info plug
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'right': [ [ 'percent' ], [ 'filetype'] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }
