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
		autocmd BufNewFile,BufReadPre * call localrc#load( g:localrc_ext_pre_filename )
	augroup END  " }}}
endif

let &cpo = s:save_cpo
unlet s:save_cpo
