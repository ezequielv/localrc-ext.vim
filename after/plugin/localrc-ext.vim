" [ezequielv] quick hack to allow for the same behavious as the 'localrc.vim'
" plugin, but hooked to the 'BufReadPre' (instead of 'BufReadPost').

if exists('g:loaded_localrc_ext')
	finish
endif
let g:loaded_localrc_ext = 1

let s:save_cpo = &cpo
set cpo&vim

" Note: we detect whether the 'localrc.vim' plugin has been loaded and active,
" and use its variables, too.
if exists( 'g:loaded_localrc' ) && g:loaded_localrc
			\	&& exists( 'g:localrc_filename' )
			\	&& ! empty( g:localrc_filename )
	if ! exists( 'g:localrc_ext_pre_filename' )
		let g:localrc_ext_pre_filename = '.local-pre.vimrc'
	endif

	augroup plugin-localrc-ext  " {{{
		autocmd!
		" fixed: ...
		"? autocmd BufNewFile * if ! exists('b:localrc_ext_fix_newfile') | call localrc#load( g:localrc_ext_pre_filename ) | let b:localrc_ext_fix_newfile=1 | try | doautocmd BufNewFile | finally | unlet! b:localrc_ext_fix_newfile | endtry
		"? autocmd BufNewFile * try | let b:localrc_ext_did_ftplugin = (exists('b:did_ftplugin') && b:did_ftplugin) | call localrc#load( g:localrc_ext_pre_filename ) | if ! b:localrc_ext_did_ftplugin | doautocmd FileType | endif | finally | unlet! b:localrc_ext_did_ftplugin | endtry
		" note: the 'unlet b:did_ftplugin' didn't seem necessary, but
		" it's tidier that way.
		autocmd BufNewFile * call localrc#load( g:localrc_ext_pre_filename ) | if exists( 'b:did_ftplugin' ) && b:did_ftplugin | unlet b:did_ftplugin | doautocmd FileType | endif
		autocmd BufReadPre * call localrc#load( g:localrc_ext_pre_filename )
	augroup END  " }}}
endif

let &cpo = s:save_cpo
unlet s:save_cpo
