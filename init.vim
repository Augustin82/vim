let vimDir = $HOME.'/.vim'

let &runtimepath.=','.vimDir
set nocompatible " be iMproved, required
set foldmethod=manual " we use CoC to handle folding
filetype off " required
syntax enable
set encoding=utf-8
set updatetime=250
set path+=**

" autocommand to open files based on current suffix
augroup suffixes
    autocmd!

    let associations = [
                \["elm", ".elm,.js"]
                \]

    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup END

" Install vim-plug if we don't already have it
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" convenient shortcuts for |> <| and -> on an AZERTY keyboard
au FileType elm inoremap <buffer> $ <bar>><space>
au FileType elm inoremap <buffer> £ <<bar><space>
au FileType elm inoremap <buffer> ; -><space>

" CoC
source ~/.vim/configs/coc.vim

filetype off
filetype plugin indent on " required!
call plug#end()
