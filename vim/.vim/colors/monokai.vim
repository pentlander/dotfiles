" Vim color file
" Converted from Textmate theme Monokai using Coloration v0.3.2 (http://github.com/sickill/coloration)

set background=dark
highlight clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256
let g:colors_name = "monokai"

let s:cfg = "231"
let s:cbg = "235"
let s:magenta = "197"
let s:cyan = "81"
let s:lavender = "141"

" Highlighting function
fun <sid>hi(group, ctermfg, ctermbg, attr)
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " cterm=" . a:attr
  endif
endfun

" ------------------------------
" Editor settings
" ------------------------------
call <sid>hi("Normal", s:cfg, "none", "none")
call <sid>hi("Cursor", s:cbg, s:cfg, "none")
call <sid>hi("CursorLine", "none", "237", "none")
call <sid>hi("LineNr", "102", "237", "none")

" ------------------------------
" Number column
" ------------------------------
call <sid>hi("CursorColumn", "none", "237", "none")
call <sid>hi("FoldColumn", s:cbg, "none", "none")
call <sid>hi("SignColumn", "NONE", "NONE", "none")
call <sid>hi("Folded", "242", s:cbg, "none")

" ------------------------------
" Window/Tab delimiters
" ------------------------------
call <sid>hi("VertSplit", "237", "237", "none")
call <sid>hi("ColorColumn", "237", "237", "none")

" ------------------------------
"  File Navigation/Searching
" ------------------------------
call <sid>hi("Directory", s:lavender, "none", "none")
call <sid>hi("Search", "none", "none", "underline")
call <sid>hi("IncSearch", s:cbg, "186", "none")

" ------------------------------
" Prompt/Status
" ------------------------------
call <sid>hi("StatusLine", s:cfg, "241", "bold")
call <sid>hi("StatusLineNC", s:cfg, "241", "none")
call <sid>hi("Title", s:cfg, "none", "bold")

" ------------------------------
" Visual Aid
" ------------------------------
call <sid>hi("MatchParen", s:magenta, "NONE", "underline")
call <sid>hi("Visual", "none", "59", "none")
call <sid>hi("NonText", "59", "none", "none")

call <sid>hi("Todo", "95", "none","none")
call <sid>hi("Underlined", "none", "none", "underline")
call <sid>hi("ErrorMsg", s:cfg, s:magenta, "none")
call <sid>hi("WarningMsg", s:cfg, s:magenta, "none")
call <sid>hi("SpecialKey", "59", "237", "none")

" ------------------------------
" Variable types
" ------------------------------
call <sid>hi("Constant", "none", "none", "none")
call <sid>hi("String", "186", "none", "none")
call <sid>hi("Character", s:lavender, "none", "none")
call <sid>hi("Number", s:lavender, "none", "none")
call <sid>hi("Boolean", s:lavender, "none", "none")
call <sid>hi("Float", s:lavender, "none", "none")

call <sid>hi("Identifier", s:cyan, "none", "none")
call <sid>hi("Function", "148", "none", "none")

" ------------------------------
" Language constructs
" ------------------------------
call <sid>hi("Statement", s:cyan, "none", "none")
call <sid>hi("Conditional", s:magenta, "none", "none")
call <sid>hi("Label", "186", "none", "none")
call <sid>hi("Operator", s:magenta, "none", "none")
call <sid>hi("Keyword", s:magenta, "none", "none")
call <sid>hi("Comment", "242", "none", "none")

call <sid>hi("Special", s:cfg, "none", "none")
call <sid>hi("Tag", s:magenta, "none", "none")

" ------------------------------
" Completion menu
" ------------------------------
call <sid>hi("Pmenu", s:cfg, s:cbg, "none")
call <sid>hi("PmenuSel", "none", "59", "none")

" ------------------------------
" C like
" ------------------------------
call <sid>hi("PreProc", s:magenta, "none", "none")
call <sid>hi("Define", s:cyan, "none", "none")
call <sid>hi("StorageClass", s:cyan, "none", "none")
call <sid>hi("Type", "none", "none", "none")

" ------------------------------
" Diff
" ------------------------------
call <sid>hi("DiffAdd", s:cfg, "64", "bold")
call <sid>hi("DiffDelete", "88", "none", "none")
call <sid>hi("DiffChange", s:cfg, "23", "none")
call <sid>hi("DiffText", s:cfg, "24", "bold")

" ------------------------------
" Ruby highlighting
" ------------------------------
call <sid>hi("rubyClass", s:magenta, "none", "none")
call <sid>hi("rubyFunction", "148", "none", "none")
call <sid>hi("rubyInterpolationDelimiter", "none", "none", "none")
call <sid>hi("rubySymbol", s:lavender, "none", "none")
call <sid>hi("rubyConstant", s:cyan, "none", "none")
call <sid>hi("rubyStringDelimiter", "186", "none", "none")
call <sid>hi("rubyBlockParameter", "208", "none", "none")
call <sid>hi("rubyInstanceVariable", "none", "none", "none")
call <sid>hi("rubyInclude", s:magenta, "none", "none")
call <sid>hi("rubyGlobalVariable", "none", "none", "none")
call <sid>hi("rubyRegexp", "186", "none", "none")
call <sid>hi("rubyRegexpDelimiter", "186", "none", "none")
call <sid>hi("rubyEscape", s:lavender, "none", "none")
call <sid>hi("rubyControl", s:magenta, "none", "none")
call <sid>hi("rubyClassVariable", "none", "none", "none")
call <sid>hi("rubyOperator", s:magenta, "none", "none")
call <sid>hi("rubyException", s:magenta, "none", "none")
call <sid>hi("rubyPseudoVariable", "none", "none", "none")
call <sid>hi("rubyRailsUserClass", s:cyan, "none", "none")
call <sid>hi("rubyRailsARAssociationMethod", s:cyan, "none", "none")
call <sid>hi("rubyRailsARMethod", s:cyan, "none", "none")
call <sid>hi("rubyRailsRenderMethod", s:cyan, "none", "none")
call <sid>hi("rubyRailsMethod", s:cyan, "none", "none")
call <sid>hi("erubyDelimiter", "none", "none", "none")
call <sid>hi("erubyComment", "95", "none", "none")
call <sid>hi("erubyRailsMethod", s:cyan, "none", "none")

" ------------------------------
" Html highlighting
" ------------------------------
call <sid>hi("htmlTag", "none", "none", "none")
call <sid>hi("htmlEndTag", "none", "none", "none")
call <sid>hi("htmlTagName", "none", "none", "none")
call <sid>hi("htmlArg", "none", "none", "none")
call <sid>hi("htmlSpecialChar", s:lavender, "none", "none")

" ------------------------------
" Javascript highlighting
" ------------------------------
call <sid>hi("javaScriptFunction", s:cyan, "none", "none")
call <sid>hi("javaScriptRailsFunction", s:cyan, "none", "none")
call <sid>hi("javaScriptBraces", "none", "none", "none")
call <sid>hi("jsFunctionKey", "148", "none", "none")

" ------------------------------
" YAML highlighting
" ------------------------------
call <sid>hi("yamlKey", s:magenta, "none", "none")
call <sid>hi("yamlAnchor", "none", "none", "none")
call <sid>hi("yamlAlias", "none", "none", "none")
call <sid>hi("yamlDocumentHeader", "186", "none", "none")

" ------------------------------
" CSS highlighting
" ------------------------------
call <sid>hi("cssURL", "208", "none", "none")
call <sid>hi("cssFunctionName", s:cyan, "none", "none")
call <sid>hi("cssColor", s:lavender, "none", "none")
call <sid>hi("cssPseudoClassId", "148", "none", "none")
call <sid>hi("cssClassName", "148", "none", "none")
call <sid>hi("cssValueLength", s:lavender, "none", "none")
call <sid>hi("cssCommonAttr", s:cyan, "none", "none")
call <sid>hi("cssBraces", "none", "none", "none")

" ------------------------------
" go highlighting
" ------------------------------
call <sid>hi("goDeclaration", s:cyan, "none", "none")
"------------------------------"
" Python highlighting
" ------------------------------
call <sid>hi("pythonBuiltin", s:magenta, "none", "none")

delf <sid>hi
