let g:ale_use_global_executables = 0
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 700
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_linters = {
\     'php': ['phpcs'],
\     'javascript': ['eslint'],
\     'typescript': ['eslint'],
\}
"\     'javascript': ['eslint'],
"\     'javascript': [{ b -> {
"\         'command': "eslint_d ".fnamemodify(bufname(b), ":p")." --fix -f unix",
"\         'process_with': { b -> [] },
"\     }}],
let g:ale_fixers = {
\     'javascript': ['eslint'],
\     'typescript': ['eslint'],
\     'php': ['php_cs_fixer'],
\     'elm': ['elm-format'],
\}
nmap <silent> <leader>a <Plug>(ale_previous_wrap)
nmap <silent> <leader>q <Plug>(ale_next_wrap)
nmap <silent> <leader>d <Plug>(ale_detail)
