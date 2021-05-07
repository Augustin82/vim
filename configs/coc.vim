set updatetime=300

let g:coc_global_extensions = [
      \'coc-diagnostic',
      \'coc-emmet',
      \'coc-eslint',
      \'coc-explorer',
      \'coc-fsharp',
      \'coc-git',
      \'coc-html',
      \'coc-json',
      \'coc-markdownlint',
      \'coc-phpls',
      \'coc-prettier',
      \'coc-snippets',
      \'coc-syntax',
      \'coc-tsserver'
      \]

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use tab and shift-tab to navigate the completion list
inoremap <silent><expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>

nmap <space>e :CocCommand explorer<CR>

" Remap for do codeAction of current line
nmap <leader>do  <Plug>(coc-codeaction)
" Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)<Paste>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use `<leader>a` and `<leader>q` to navigate diagnostics
nmap <silent> <leader>a <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>q <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>ga :CocNext diagnostics<CR>
nnoremap <silent> <leader>gq :CocPrevious diagnostics<CR>

" Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd :<C-u>call CocActionAsync('jumpDefinition')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <leader>rf <Plug>(coc-references)

inoremap <silent><expr> <c-space> coc#refresh()

" manual format
" nmap <silent> <leader>fo :<C-u>call CocActionAsync('format')<CR>
" Add :Format command to format buffer
command! Format :call CocActionAsync('format')

nmap <silent> <leader><BS> :Format<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" function! ShowDocIfNoDiagnostic(timer_id)
"   if (coc#util#has_float() == 0)
"     silent call CocActionAsync('doHover')
"   endif
" endfunction
"
" function! s:show_hover_doc()
"   call timer_start(500, 'ShowDocIfNoDiagnostic')
" endfunction

" autocmd CursorHoldI * :call <SID>show_hover_doc()
" autocmd CursorHold * :call <SID>show_hover_doc()

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>cd :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>ce :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>cc :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>co :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>cs :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>cj :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <leader>ck :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <leader>cp :<C-u>CocListResume<CR>

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
