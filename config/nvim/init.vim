" ==== this.ajk@gmail.com @ 28 Jan 2020====
 " === best init.vim for nvim or can be used for vim as well===
 " === platform independent , applicable for most OS including ms windows
"-------------------

" ==== below code is for to use existing vim .vimrc for nvim ====
  " === keep commented unless it used, if it is used, then remove all other code in this file
    ""set runtimepath^=~/.vim runtimepath+=~/.vim/after
    ""let &packpath = &runtimepath
    ""source ~/.vimrc
  "  
"------------------------

" ==== steps to install plugins ==== *
  " you need to execute vim/nvim and in command mode i.e by clicking : key execute PlugIntall <enter>
  " it will install all plug-in listed below in this file
"---------------------


" ==== xxxx ====
  let fancy_symbols_enabled = 1
" ----------

" ==== xxxx ====
  set encoding=utf-8
  let using_neovim = has('nvim')
  let using_vim = !using_neovim
" -----------




" ==== Vim-plug initialization ====
  " Avoid modifying this section, unless you are very sure of what you are doing
  
  let vim_plug_just_installed = 0
  
  if using_neovim
      let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
    else
      let vim_plug_path = expand('~/.vim/autoload/plug.vim')
  endif
  
  if !filereadable(vim_plug_path)
      echo "Installing Vim-plug..."
      echo ""
      if using_neovim
          silent !mkdir -p ~/.config/nvim/autoload
          silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        else
          silent !mkdir -p ~/.vim/autoload
          silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      endif
      let vim_plug_just_installed = 1
  endif

  " manually load vim-plug the first time
  if vim_plug_just_installed
      :execute 'source '.fnameescape(vim_plug_path) 
  endif
"-----------------------------------------

" ==== Note ====
  " Obscure hacks done, you can now modify the rest of the config down below 
  " as you wish :)
  " IMPORTANT: some things in the config are vim or neovim specific. It's easy 
  " to spot, they are inside `if using_vim` or `if using_neovim` blocks.
"

" ==== plugin install using vim plug ====
  " Active plugins
  " You can disable or add new ones here:

  " this needs to be here, so vim-plug knows we are declaring the plugins we
  " want to use
"

" ==== set plugged folder ====
  if has('win32') || has('win64')
    let g:plugged_home = '~/AppData/Local/nvim/plugged'
    else
      if using_neovim
        let g:plugged_home = '~/.config/nvim/plugged' 
        else   
        let g:plugged_home = '~/.vim/plugged'
      endif
  endif
"--------------------------


" ==== Plugins List ====
  call plug#begin(g:plugged_home)

    " === UI related ===
      "colorscheme
        Plug 'chriskempson/base16-vim'
        Plug 'dracula/vim', { 'as': 'dracula' }
        Plug 'morhetz/gruvbox'
        Plug 'patstockwell/vim-monokai-tasty'
      "
      " status bar
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
      "

      " Better Visual Guide
        Plug 'Yggdroot/indentLine'
      "

      "syntax check
        Plug 'w0rp/ale'
      "

      "Autocomplete
        Plug 'ncm2/ncm2'
        Plug 'roxma/nvim-yarp'
        Plug 'ncm2/ncm2-bufword'
        Plug 'ncm2/ncm2-path'
        Plug 'ncm2/ncm2-jedi'
      "

      " Formater
        Plug 'Chiel92/vim-autoformat'
      "
    "
    " file handeling
      " Code and files fuzzy finder
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'junegunn/fzf.vim'
      "
    "file search plugin
        Plug 'liuchengxu/vim-clap'
    "

    " ==== R programming ====
        Plug 'jalvesaq/Nvim-R'
        " Plug 'roxma/nvim-completion-manager' do not use has issue
        Plug 'gaalcaras/ncm-R'
        " Optional: for snippet support
        Plug 'sirver/UltiSnips'
        

        " when you are seeking more information on a piece of R code
        Plug 'rizzatti/dash.vim'
        " 
       " R markdown
       Plug 'vim-pandoc/vim-pandoc'
       Plug 'vim-pandoc/vim-pandoc-syntax'
       Plug 'vim-pandoc/vim-rmarkdown'

    "------------------------
    
  call plug#end()
"----------------------------

" ==== indenting ====
  filetype plugin indent on
"

" Configurations Part
  " UI configuration
    syntax on
    syntax enable
  "

  " set colorscheme
    let base16colorspace=256
    set background=dark

    "colorscheme base16-gruvbox-dark-hard
    "colorscheme dracula
    "colorscheme gruvbox
    "colorscheme base16-gruvbox-dark-pale
    "colorscheme delek
    colorscheme vim-monokai-tasty
  "

  " True Color Support if it's avaiable in terminal
  " Below code sometime make colorscheme NOT work, so please comment it out
    if has("termguicolors")
        "set termguicolors 
    endif
  "

  "font setting
    set guifont=Monaco:h40
  "
  
  " gui vs non gui vim version
    if has("gui_running")
      set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:blocks
    endif

" ==== Other settings ====
  let mapleader = "l"

  set number
  set relativenumber
  set hidden
  set mouse=a
  set noshowmode
  set noshowmatch
  set nolazyredraw
  " Turn off backup
  set nobackup
  set noswapfile
  set nowritebackup
  " Search configuration
  set ignorecase                    " ignore case when searching
  set smartcase                     " turn on smartcase
  " Tab and Indent configuration
  set expandtab
  set tabstop=4
  set shiftwidth=4
  " vim-autoformat
  noremap <F3> :Autoformat<CR>
  " NCM2
"
"=== augroup ====
  augroup NCM2
    autocmd!
    " enable ncm2 for all buffers
    autocmd BufEnter * call ncm2#enable_for_buffer()
    " :help Ncm2PopupOpen for more information
    set completeopt=noinsert,menuone,noselect
    " When the <Enter> key is pressed while the popup menu is visible, it only
    " hides the menu. Use this mapping to close the menu and also start a new line.
    inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
    " uncomment this block if you use vimtex for LaTex
    " autocmd Filetype tex call ncm2#register_source({
    "           \ 'name': 'vimtex',
    "           \ 'priority': 8,
    "           \ 'scope': ['tex'],
    "           \ 'mark': 'tex',
    "           \ 'word_pattern': '\w+',
    "           \ 'complete_pattern': g:vimtex#re#ncm2,
    "           \ 'on_complete': ['ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
    "           \ })
  augroup END
"

" ==== Ale ===
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_echo_msg_error_str = 'E'
  let g:ale_echo_msg_warning_str = 'W'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_linters = {'python': ['flake8']}
  " Airline
  let g:airline_left_sep  = ''
  let g:airline_right_sep = ''
  let g:airline#extensions#ale#enabled = 1
  let airline#extensions#ale#error_symbol = 'E:'
  let airline#extensions#ale#warning_symbol = 'W:'
" ----------------------------------------------

" ==== Python ==== 
  "=== how to execute python code === in same window of vim i.e from inside vim ===
    " manual by typing "!clear;python %" please mind space between python and %
    "imap <F5> <Esc>:w<CR>:!clear;python %<CR>
    "nnoremap <F10> :echo system('python3 "' . expand('%') . '"')<cr>
    "nnoremap <buffer> <F9> :w <bar> :exec '!python' shellescape(@%, 1)<cr>
    "xnoremap <leader>p :w !python<cr>
    "nnoremap <leader>p :w !python<cr>
    "nnoremap <leader>p :w | !python %<cr>
  "

  " select python code (visual mode by pressing v) and press shit + p to execute
    fu PyRun() range
      echo system('python -c ' . shellescape(join(getline(a:firstline, a:lastline), "\n")))
    endf
    vmap <S-P> :call PyRun()<CR>
  "

  " run python file by pressing control + P
    "nnoremap <C-P> :w | !python %<cr>
    nnoremap <C-P> :echo system('python3 "' . expand('%') . '"')<cr>
  "
" -----------------------------------------
" ==== R programming ====
  " remapping the basic :: send line
    nmap , <Plug>RDSendLine
    " remapping selection :: send multiple lines
    vmap , <Plug>RDSendSelection
    " remapping selection :: send multiple lines + echo lines
    vmap ,e <Plug>RESendSelection

    " R output is highlighted with current colorscheme
      let g:rout_follow_colorscheme = 1
      " R commands in R output are highlighted
      let g:Rout_more_colors = 1
    "
    "when you are seeking more information on a piece of R code
      " remap search key
        nmap <silent> <leader>d <Plug>DashGlobalSearch<CR>

    " R language server
    let g:LanguageClient_serverCommands = {
    \ 'r': ['R', '--slave', '-e', 'languageserver::run()'],
    \ }
" ----------------------------------