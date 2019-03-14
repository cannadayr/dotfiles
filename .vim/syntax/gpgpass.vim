" Vim syntax file
" Language: GPG Passwords
" Latest Revision: 01 Augist 2016
" USAGE:
" mydomain.com{{{
"   myuser{{{
"       pass:myhiddenpass
"   }}}
" }}}
if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "gpgpass"

"syntax case ignore

syn match   passwdToken   /pass:/ nextgroup=passwd skipwhite
syn match   passwd      /.*/ contained conceal cchar=*

"" Group highlights
"hi def link passwdToken Keyword
"hi def link passwd Special

"" Passwd concealment
setlocal conceallevel=1
setlocal concealcursor=nvic

