" Nvim Configuration
" IDEAS
" 1.make telescope mapping for adding a file as a split
" 2.make mapping for closing split without deleting buffer

source ~/.config/nvim/settings.vim
source ~/.config/nvim/basemaps.vim
source ~/.config/nvim/autocomands.vim

" Plugin Configuration
source ~/.config/nvim/plugin_configs/plugins.vim
source ~/.config/nvim/plugin_configs/plug_adjust.vim
source ~/.config/nvim/plugin_configs/coc.vim
source ~/.config/nvim/plugin_configs/quickscope.vim
source ~/.config/nvim/plugin_configs/start_screen.vim
source ~/.config/nvim/plugin_configs/undotree.vim
source ~/.config/nvim/plugin_configs/laf.vim
source ~/.config/nvim/plugin_configs/telescope.vim

autocmd BufReadPost,FileReadPost *.vs setfiletype glsl
" functions
" source ~/.config/nvim/functions/r1ri_foldtext.vim
