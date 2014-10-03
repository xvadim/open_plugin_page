" =============================================================================
" File:         
" Description:  
" Maintainer:   Vadim A. Khohlov  <xvadima at ukr dot net>
" Last Change:  
" Version:      0.9
" License:      GPL
" -----------------------------------------------------------------------------

" Prevent multi loading
if exists("g:open_plugin_page")
    finish
endif
let g:open_plugin_page = 1

if !exists("g:opp_open_command")
    let g:opp_open_command = "open"
endif

func! s:parse_name(arg)
    " borrowed from vundle#config#s:parse_name
    let arg = a:arg
    if arg =~? '^\s*\(gh\|github\):\S\+' || arg =~? '^[a-z0-9][a-z0-9-]*/[^/]\+$'
        let uri = 'https://github.com/'.split(arg, ':')[-1]
    elseif arg =~? '^\s*\(git@\|git://\)\S\+' || arg =~? '\(file\|https\?\)://'
        let uri = arg
    else
        let uri  = 'https://github.com/vim-scripts/'.arg
    endif
  return substitute(uri,'/\?\.git\s*$','','i')
endf


function! s:OpenPluginPage()
    " TODO: more elegant plugin name extraction
    let uri = s:parse_name(substitute(substitute(getline('.'), "^[^']*'","",""), "'.*$","", ""))
    if uri =~? '^https\?://'
        silent exec "!".g:opp_open_command." '".uri."'"
    else
        echo "Can't open ".uri
    endif
endfun

if !hasmapto('<Plug>OpenPluginPage')
    map <unique> <leader>o <Plug>OpenPluginPage
endif

noremap <unique> <script> <Plug>OpenPluginPage <SID>OpenPluginPage
noremap <SID>OpenPluginPage :call <SID>OpenPluginPage()<CR>
