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
color dracula
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
let g:ycm_global_ycm_extra_conf = '$HOME/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf =0

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
let s:main_window = -1
fun! SearchMainWindow()
	let c = 1
	while c <= bufnr("$") && s:main_window < 0
		if buflisted(c) != 0 && bufwinnr(c) > 0 
			let s:main_window = bufwinnr(c)
		endif
		let c = c + 1
	endwhile
endfun

fun! DoNotOpenFilesInNerdOrTagList()
	if bufname("#") =~ 'NERD_tree_.*' && buflisted(bufnr("#")) == 0 
		if(s:main_window < 0)
			call SearchMainWindow()
		endif
		if s:main_window> 0
			let curBuf = bufnr("")
			b#
			execute s:main_window . 'wincmd w'
			execute 'buf '. curBuf
		endif
		return
	endif
	"tab sball
endfun

:au BufWinEnter * nested call DoNotOpenFilesInNerdOrTagList()
