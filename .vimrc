set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin('$HOME/.vim/bundle/')


" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'honza/vim-snippets'
Plugin 'taglist.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'dracula/vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'stiffme/ycm_simple_conf'
"Plugin 'tdcdev/ycm_simple_conf'
"Plugin 'fholgado/minibufexpl.vim'
"Plugin 'wesleyche/SrcExpl'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

filetype on
"color dracula
colorscheme desert
if has("syntax")
	syntax on
endif

set number
set laststatus=2
set guifont=Consolas:h11:cANSI
set tags=tags;
"set autochdir
set backspace=indent,eol,start
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#ycm#enabled = 1
let g:ycm_global_ycm_extra_conf = '$HOME/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf =0
let g:ctrlp_by_filename =1
let g:ctrlp_switch_buffer = 'et'
let g:ctrlp_tabpage_position = 'c'
let g:ctrlp_working_path_mode = 'r'
set rop=type:directx,gamma:1.0,contrast:0.5,level:1,geom:1,renmode:4,taamode:1
"NERDTree startup when no args is given
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | wincmd p | endif

nnoremap <Leader>f :NERDTreeToggle<Enter>
"let NERDTreeQuitOnOpen = 1
"close a tab if the only remaining window is NerdTree
autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

let NERDTreeShowBookmarks = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


"taglist
let Tlist_Use_Right_Window  = 1
let Tlist_Exist_OnlyWindow = 1
let Tlist_Ctags_Cmd=$VIMRUNTIME.'/ctags.exe'
let Tlist_Auto_Open = 1
let Tlist_Show_One_File = 1
nmap <C-T> :TlistToggle <Enter>
"autocmd BufEnter *.c,*.cc,*.cpp,*.cxx,*.h,*.hh :TlistOpen
"ctrlp ignore
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|o)$',
  \ }
nmap <C-TAB> <Plug>AirlineSelectNextTab
nmap <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"find a proper window to show
fun! DoNotOpenFilesInNerdOrTagList(theFile)
	if exists("b:NERDTreeType") && b:NERDTreeType == "primary" 
		let curBuf = bufnr("")
		let bufend = bufnr("$")
		let c = 1
		while c <= bufend
			if c != curBuf && buflisted(c) != 0 && bufwinnr(c) > 0
				b#
				execute c . "wincmd w"
				execute 'buf ' . curBuf
				return 
			endif
			let c = c + 1
		endwhile

		b#
		execute "vsp | b".curBuf
	endif
endfun

:au BufWinEnter * nested call DoNotOpenFilesInNerdOrTagList(expand("<afile>:p"))
