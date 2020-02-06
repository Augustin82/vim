if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
" the very first line of the syntax message, with [elm] [...]
syn match ElmErrorType "^\[.*] "
" the line number at the beg of a line
syn match ElmLineNb "^\d*|"
" the line number with the error
syn match ElmLineWithError "^\d*|#>#.*" contains=ElmUnderlineDelim
" suggestions, surrounded by #, which should be hidden
syn match Elmsuggestion "#[^#]*#" contains=ElmUnderlineDelim
" the underline ^^^^ indicators, surrounded by #, which should be hidden
syn match ElmUnderline "#^*#" contains=ElmUnderlineDelim
syn match ElmUnderlineDelim "#" contained conceal
" identifiers, surrounded by ` (would should be hidden)
syn match ElmIdentifier "`[^`]*`" contains=ElmIdentifierDelim
syn match ElmIdentifierDelim "`" contained conceal
" hints
syn match ElmHint "^#[^#]*#" contains=ElmUnderlineDelim
" html links
syn match ElmHtml "<http.*>" contains=ElmHtmlDelim
syn match ElmHtml "http[^ ]*"
syn match ElmHtmlDelim "<" contained conceal
syn match ElmHtmlDelim ">" contained conceal
hi! def link ElmHtml Underlined
hi! def link ElmErrorType Statement
hi! def link ElmLineWithError Error
hi! def link ElmLineNb Todo
hi! def link ElmHint String
hi! def link ElmUnderline Error
hi! def link ElmSuggestion Function
hi! def link ElmIdentifier Identifier
let b:current_syntax = "elmerror"
