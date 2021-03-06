function! SourceFileFunction( filename )
   if filereadable( a:filename )
      execute "source ".a:filename
   endif
endfunction
command! -complete=file -nargs=1 SourceFile call SourceFileFunction(<args>)

"set runtimepath+=/usr/share/vim/vimfiles

" Arista Include the system settings
SourceFile "/etc/vimrc"
SourceFile "/usr/share/vim/vimfiles/arista.vim"

"
" Put your own customizations below
"

"" vim plug section
   " Specify a directory for plugins
   " - For Neovim: ~/.local/share/nvim/plugged
   " - Avoid using standard Vim directory names like 'plugin'
   call plug#begin('~/.vim/plugged')

      " Think of sensible.vim as one step above 'nocompatible' mode
      Plug 'tpope/vim-sensible'
      " Plug 'python-mode/python-mode', { 'branch': 'develop' }
      " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
      Plug 'junegunn/vim-easy-align'
      " https://medium.com/@crashybang/supercharge-vim-with-fzf-and-ripgrep-d4661fc853d2
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
      Plug 'junegunn/fzf.vim'
      " Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
      Plug 'skywind3000/asyncrun.vim'
      " Create text objects without pain
      Plug 'kana/vim-textobj-user'
      Plug 'bps/vim-textobj-python'
      Plug 'kana/vim-textobj-diff'
      Plug 'tpope/vim-fugitive'
      Plug 'majutsushi/tagbar'
      Plug 'xolox/vim-session'
      Plug 'xolox/vim-misc'
      " Mark, multiple highlights
      " Plug 'inkarkat/vim-mark'
      " Plug 'inkarkat/vim-ingo-library'

      "Plug 'ngemily/vim-vp4' # Supposed to be good for perforce, try this
      Plug 'mhinz/vim-signify'
      " Plug 'vim-scripts/ZoomWin'
      " Plug 'tpope/vim-dispatch'
      " Plug 'dhruvasagar/vim-zoom'

   " Initialize plugin system
   call plug#end()

"" Map Leader
   :let mapleader=" "

"" Asyncrun plugin settings
   let g:asyncrun_auto = "make"
   let g:asyncrun_open = 8 " set the quickfix window 8 lines height.
   let g:asyncrun_bell = 1 " ring the bell to notify you job finished

"" Arista specific
   " make packages
   SourceFile "/home/akhil/dotfiles/.vimrc_aristamake"
   " switch between files
   SourceFile "/home/akhil/dotfiles/.vimrc_arista_switchfiles"
   nmap <Leader>s :call SwitchSourceHeader()<CR>
   nmap <Leader>ss :call VerticalOpenSourceHeader()<CR>
   " Checkout file from perforce
   " SourceFile "/home/akhil/dotfiles/.vimrc_arista_checkout"

"" http://vimdoc.sourceforge.net/htmldoc/filetype.html
"" detect file, loads file-plugin and process runtime indentation if present 
   filetype plugin on
   filetype plugin indent on

"" Fold
   set foldmethod=indent
   "set foldnestmax=10
   set nofoldenable
   "set foldlevel=2

"" Indentation
   set autoindent
   set cindent cinoptions=(0
   set shiftwidth=3 " affects what happens when you press >>, << or ==
   set textwidth=85
   set paste
   "Shows the row,column at the bottom right of status line
   set ruler
   set colorcolumn=+1
   set wrap
   "set smarttab softtabstop=3
   "set tabstop=3
   set expandtab
   set backspace=indent,eol,start
   set number
   set splitright

"" cscope
   "if filereadable( a:filename )
      setlocal nocscopeverbose " temporarily disable cscope warning
      cs add /src/pycscope.out /src
      cs add /src/cscope.out /src
      cs reset " if it is already added, reset
      setlocal cscopeverbose
      setlocal cscopetag " always search cscope database first and then tag files
   "endif
   " nmap <C-/>] :cs find c <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>cc :cs find c <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>cd :cs find d <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>ce :cs find e <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>cf :cs find f <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>cg :cs find g <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>ci :cs find i <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>cs :cs find s <C-R>=expand("<cword>")<CR><CR>
   nnoremap <Leader>ct :cs find t <C-R>=expand("<cword>")<CR><CR>

"" Typos
   nnoremap :Cs :cs
   nnoremap :W :w
   nnoremap :Q :q
   nnoremap :w:q :wq
   " nnoremap m<Leader> <Leader>
   " tnoremap m<Leader> <Leader>

"" Key Maps
   function! SeeSpaceTabs()
      set list
      set listchars=tab:>-,trail:~,extends:>,precedes:<
      " echom "SeeSpaceTabs"
   endfunction
   nnoremap <Leader>qq :call SeeSpaceTabs()<cr>
   nnoremap <Leader>qw :set nolist<CR>

   nmap gr :tabprevious<CR>
   nnoremap <Leader>qp :set ai <bar> set sw=3 <bar> set expandtab <bar> set tabstop=3 <bar> set softtabstop=3<CR>
   nnoremap <Leader>\ :vertical term<cr>
   nnoremap <Leader>- :term<cr>
   " terminal mode
   tnoremap <Leader>,\ <C-W>:vertical term<cr>
   tnoremap <Leader>,- <C-W>:term<cr>
   tnoremap <Leader><Leader> <C-W>N
   "tnoremap <silent> <Leader>b :Buffers<cr>
   " vim tab
   nnoremap <Leader>t :tabedit 
   noremap <Leader>t<Left>  :tabmove -1<CR>
   noremap <Leader>t<Right> :tabmove +1<CR>
   " set tabstop alias
   nnoremap <Leader>8 :set sw=8 <bar> set tabstop=8 <bar> set softtabstop=8 <bar> set ai <bar> set textwidth=110<CR>
   nnoremap <Leader>3 :set sw=3 <bar> set tabstop=3 <bar> set softtabstop=3 <bar> set ai <bar> set textwidth=85<CR>
   nnoremap <Leader>33 :set sw=3 <bar> set tabstop=3 <bar> set softtabstop=3 <bar> set ai <bar> set textwidth=85 <bar> set expandtab<CR>

   " Easier split navigations in normal and terminal modes
   nnoremap <Leader><Up> <C-W><C-K>
   nnoremap <Leader><Down> <C-W><C-J>
   nnoremap <Leader><Left> <C-W><C-H>
   nnoremap <Leader><Right> <C-W><C-L>
   nnoremap <Leader>k <C-W><C-K>
   nnoremap <Leader>j <C-W><C-J>
   nnoremap <Leader>h <C-W><C-H>
   nnoremap <Leader>l <C-W><C-L>
   tnoremap <Leader><Up> <C-W><C-K>
   tnoremap <Leader><Down> <C-W><C-J>
   tnoremap <Leader><Left> <C-W><C-H>
   tnoremap <Leader><Right> <C-W><C-L>
   "tnoremap <Leader>k <C-W><C-K>
   "tnoremap <Leader>j <C-W><C-J>
   "tnoremap <Leader>h <C-W><C-H>
   "tnoremap <Leader>l <C-W><C-L>
   "tnoremap <Leader>p <C-W>".

   " zoom
   nnoremap <Leader>Z <C-W>_<bar><C-W>|
   nnoremap <Leader>z <C-W>=
   tnoremap <Leader>Z <C-W>_<C-W>| " not working!!??
   tnoremap <Leader>z <C-W>=
   " Bind <leader>y to forward last-yanked text to Clipper
   nnoremap <leader>Y :call system('nc localhost 8377', @0)<CR>

   " goto beginning/end of scope
   map [[ ][%0
   map ]] ][][%0

   map ˚ :res +5<cr>
   map ∆ :res -5<cr>
   " vnoremap <C-c> "*y " When did I do this and why ??
   "Delete all searched occurances in this file
   nnoremap <Leader>dd :%s/<cr>//gn 
   " Count number of matches
   nnoremap \n :%s///gn<CR>

   " nnoremap <Leader>f /\c<C-R>=expand("<cword>")<CR><CR>
   " nnoremap <Leader>fc /<C-R>=expand("<cword>")<CR><CR>
   " Add word under cursor to search pattern
   " nnoremap <Leader>ff :let @/.='\\|\<'.expand("<cword>").'\>'<CR>

" let g:python_recommended_style = 0

"" ctags
   "set nocscopetag
   "set tags=tags;/
   "map <C-;> :tab split<CR>:exec("tag ".expand(""))<CR>
   "map <C-\> :vsp <CR>:exec("tag ".expand(""))<CR>

"" General
   set scrolloff=5 " Working line 'scrolloff' lines above or below
   set showmode " show in which vim mode are you in
   set showcmd " not working

   set statusline=%F         " Path to the file
   set statusline+=%r        " File name
   set statusline+=%=        " Switch to the right side
   set statusline+=%l        " Current line
   set statusline+=/         " Separator
   set statusline+=%L        " Total lines
   set laststatus=2

   set showmatch " bracket match, help for details
   set more " by default it is on.
   set incsearch " highlight as you search
   set hlsearch " highlight all search patterns
   set ignorecase
   set smartcase " ignorecase and smartcase must be present for smartcase to work

   set is " ????
   set visualbell " Dont make sound
   set pastetoggle=<F2>
   " what ? below line ?
   nnoremap <C-p>[ :AGid -d <C-R>=expand("<cword>")<CR><CR>

   syntax enable
   set clipboard=unnamed
   cd /src

" autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window %")

"if exists("$TMUX")
"  if exists("$TMUX_WINDOW_NAME")
"    autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window $TMUX_WINDOW_NAME/"  . expand("%:t"))
"    autocmd VimLeave * call system("tmux rename-window $TMUX_WINDOW_NAME")
"  else
"    autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
"    autocmd VimLeave * call system("tmux setw automatic-rename")
"  endif
"endif

set grepprg=rg\ --vimgrep

" in place search
function! s:inplace_search_start()
    let b:orig_cursor_pos = getpos('.')
    cnoremap <buffer> <CR> <CR>:call <SID>inplace_search_stop()<CR>
endfunction

function! s:inplace_search_stop()
    cunmap <buffer> <CR>
    if line('.') != b:orig_cursor_pos[1]
        call setpos('.', b:orig_cursor_pos)
    endif
endfunction
" TODO Learn what is SID ?
map g/ :call <SID>inplace_search_start()<CR>/
map g? :call <SID>inplace_search_start()<CR>?

"------------------------------
" Plugin related configurations
"------------------------------

" FZF Plugin related: https://github.com/junegunn/fzf.vim
   " FZF Global commands
   " This is the default extra key bindings
   let g:fzf_action = {
     \ 'ctrl-q': 'split | wall | bdelete',
     \ 'ctrl-t': 'tab split',
     \ 'ctrl-x': 'split',
     \ 'ctrl-v': 'vsplit' }

   " Default fzf layout
   " - down / up / left / right
   let g:fzf_layout = { 'down': '~40%' }

   " In Neovim, you can set up fzf window using a Vim command
   "let g:fzf_layout = { 'window': 'enew' }
   "let g:fzf_layout = { 'window': '-tabnew' }
   "let g:fzf_layout = { 'window': '10split enew' }

   " Customize fzf colors to match your color scheme
   let g:fzf_colors =
   \ { 'fg':      ['fg', 'Normal'],
     \ 'bg':      ['bg', 'Normal'],
     \ 'hl':      ['fg', 'Comment'],
     \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
     \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
     \ 'hl+':     ['fg', 'Statement'],
     \ 'info':    ['fg', 'PreProc'],
     \ 'border':  ['fg', 'Ignore'],
     \ 'prompt':  ['fg', 'Conditional'],
     \ 'pointer': ['fg', 'Exception'],
     \ 'marker':  ['fg', 'Keyword'],
     \ 'spinner': ['fg', 'Label'],
     \ 'header':  ['fg', 'Comment'] }

   " Enable per-command history.
   " CTRL-N and CTRL-P will be automatically bound to next-history and
   " previous-history instead of down and up. If you don't like the change,
   " explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
   let g:fzf_history_dir = '~/.local/share/fzf-history'

   " Command for git grep
   " - fzf#vim#grep(command, with_column, [options], [fullscreen])
   command! -bang -nargs=* GGrep
     \ call fzf#vim#grep(
     \   'git grep --line-number '.shellescape(<q-args>), 0,
     \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)

   " Override Colors command. You can safely do this in your .vimrc as fzf.vim
   " will not override existing commands.
   command! -bang Colors
     \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'}, <bang>0)

   " Augmenting Ag command using fzf#vim#with_preview function
   "   * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
   "     * For syntax-highlighting, Ruby and any of the following tools are required:
   "       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
   "       - CodeRay: http://coderay.rubychan.de/
   "       - Rouge: https://github.com/jneen/rouge
   "
   "   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
   "   :Ag! - Start fzf in fullscreen and display the preview window above
   command! -bang -nargs=* Ag
     \ call fzf#vim#ag(<q-args>,
     \                 <bang>0 ? fzf#vim#with_preview('up:60%')
     \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
     \                 <bang>0)


   " --column: Show column number
   " --line-number: Show line number
   " --no-heading: Do not show file headings in results
   " --fixed-strings: Search term as a literal string
   " --ignore-case: Case insensitive search
   " --no-ignore: Do not respect .gitignore, etc...
   " --hidden: Search hidden files and folders
   " --follow: Follow symlinks
   " --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
   " --color: Search color options
   " Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:

   command! -bang -nargs=* Rg
   \ call fzf#vim#grep(
   \   'rg --smart-case --vimgrep --type-add "ar:*.{tac,tin,py,ar,am}" --type-add "tac:*.tac" --type-add "tin:*.tin" --no-ignore --glob "!pylint*" --glob "!Makefile.in*" --glob "!pycscope*" --glob "!newpycscope*" --glob "!cscope*" --glob "!taccscope*" --glob "!fzfsrc" --color=always '.<q-args>, 1,
   \   <bang>0 ? fzf#vim#with_preview('up:60%')
   \           : fzf#vim#with_preview('right:50%'),
   \   <bang>0)

   command! -bang -nargs=* RgMyDirs
   \ call fzf#vim#grep(
   \   'rg --follow --smart-case --vimgrep --type-add "ar:*.{tac,tin,py,ar,am}" --type-add "tac:*.tac" --type-add "tin:*.tin" --no-ignore --glob "!pylint*" --glob "!Makefile.in*" --glob "!pycscope*" --glob "!newpycscope*" --glob "!cscope*" --glob "!taccscope*" --color=always '.<q-args>, 1,
   \   <bang>0 ? fzf#vim#with_preview('up:60%')
   \           : fzf#vim#with_preview('right:50%'),
   \   <bang>0)

   command! -bang -nargs=* RgMyDirsCword
   \ call fzf#vim#grep(
   \   'rg --smart-case --vimgrep --glob "ArBgp*" --glob "Bgp*" --glob "!pylint*" --color=always '.expand('<cword>'), 1,
   \   <bang>0 ? fzf#vim#with_preview('up:60%')
   \           : fzf#vim#with_preview('right:50%'),
   \   <bang>0)

   " Likewise, Files command with preview window
   command! -bang -nargs=? -complete=dir FilesRoutingWorking
       \  call fzf#run(fzf#vim#with_preview(fzf#wrap({'source': 'find /src/Bgp* /src/ArBgp* /src/gated* -type f',
       \ 'sink':  'edit' }), 'right:70%' ), <bang>0)

   command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

   command! -bang -nargs=? -complete=dir FileCWord
     \ call fzf#vim#files(<q-args>, {'options':'--query '.expand('<cword>')})

   " Alias for fzf
   nnoremap <silent> <leader><space> :Files /src/fzfsrc<CR>
   nnoremap <silent> <leader>a :Files /src<CR>

   "nnoremap <silent> <Leader><space> :Files <C-R>=expand('%:h')<CR><CR>
   nnoremap <silent> <leader>, :FileCWord /src<CR>
   nnoremap <silent> <Leader>b :Buffers<cr>
   nnoremap <Leader>r :cd /src/fzfsrc <bar> :RgMyDirs 
   nnoremap <Leader>R :cd /src <bar> :RgMyDirsCword<cr>
   nnoremap <Leader>e :cd /src <bar> :Rg 

" easy align
   " Start interactive EasyAlign in visual mode (e.g. vipga)
   xmap ga <Plug>(EasyAlign)

   " Start interactive EasyAlign for a motion/text object (e.g. gaip)
   nmap ga <Plug>(EasyAlign)

" Plugin python-mode
   "let g:pymode_python = 'python'
   "let g:pymode_trim_whitespaces = 0
   "let g:pymode_run_bind = '<leader>x'
   "let g:pymode_breakpoint_bind = '<leader>k'

   " Alias for pymode

" Plugin Tagbar
   nnoremap <F8> :TagbarToggle<CR>

" Plugin vim-sessions
   if empty($WP)
      :let g:session_autosave = 'no'
      :let g:session_autoload = 'no'
   else
      :let g:session_directory = '/src/vim-sessions/'
      :let g:session_autosave = 'yes'
      ":let g:session_autosave_to = "Session-$HOSTNAME.vim"
      :let g:session_autosave_periodic = 60
      :let g:session_autoload = 'yes'
   endif

" signify for perforce
   let g:signify_vcs_list = [ 'perforce' ]
   let g:signify_vcs_cmds = {
      \ 'perforce': 'a p4 diff -du 0 %f' }
   let g:signify_vcs_cmds_diffmode = {
      \ 'perforce': 'a p4 diff %f' }

" vim-mark
   "nmap f <Plug>MarkSearchGroupNext
"<Plug>MarkSearchUsedGroupNext
   "nmap t <Plug>MarkSearchGroupPrev
