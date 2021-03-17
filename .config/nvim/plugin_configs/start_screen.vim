let g:startify_fortune_use_unicode = 1
let g:startify_change_to_dir = 0
let g:startify_lists = [
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
          \ { 'type': 'files',     'header': ['   MRU']            },
          \ { 'type': 'commands',  'header': ['   Commands']       },
          \ ]

nnoremap <silent><leader>sc :SClose<Return>
