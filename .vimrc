" O HAI
" .vimrc
" @imkmf

" Bundles {{{

" Bundle: tpope/vim-pathogen
execute pathogen#infect()

" Bundles
"
" Bundle: amiel/vim-tmux-navigator
" Bundle: tpope/vim-sensible
" Bundle: bling/vim-airline
" Bundle: endwise.vim
" Bundle: tpope/vim-commentary
" Bundle: jtratner/vim-flavored-markdown
" Bundle: kchmck/vim-coffee-script
" Bundle: tpope/vim-surround
" Bundle: mustache/vim-mustache-handlebars
" Bundle: tpope/vim-rails
" Bundle: 'luochen1990/rainbow'
" Bundle: 'tpope/vim-fugitive'

" }}}

" vimrc settings {{{
" .vimrc folding
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Reload .vimrc on save (good for editing)
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" Unfold with space!

" }}}

" Basics {{{

" Gratuitous theft from
" https://bitbucket.org/sjl/dotfiles
" Disable vim modeline
set modelines=0

" Mode indications
"set showmode
set noshowmode
set showcmd

" Retain buffers until quit
set hidden

" No bells!
set visualbell

" Tell vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
set listchars=tab:--,trail:·

" Fast scrolling
set ttyfast

" Path/file expansion in colon-mode.
set wildmode=longest:full,list:full,list:longest
set wildchar=<TAB>

" Better dividers
set isk+=_,$,@,%,#,-

" Space it out a little more (easier to read)
set lsp=0

" Line numbers are nice
set ruler

" Backspace for normal people
set backspace=indent,eol,start

" Always show status
set laststatus=2

" Show whitespace
"set list

" Pretty self-explanatory
set lazyredraw

" Brace face
set showmatch
set matchtime=3

" Split down and right
set splitbelow
set splitright

" Good indentation
" set shiftround

" Read filetype stuff
filetype plugin on
filetype indent on

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" Better Completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview

" Resize splits when the window is resized
au VimResized * :wincmd =

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use spaces instead of tabs
"set expandtab

" Be smart when using tabs ;)
set autoindent
set smarttab

" 1 tab == 2 spaces
set shiftwidth=4
set tabstop=4

" Search shows all results
set hlsearch

" }}}

" History/Undo settings {{{

" We have computers with pretty big
" hard drives, so let's keep these
set history=1000
set undofile
set undodir=~/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set backupdir=~/.vim/backup/
set directory=~/.vim/backup/
" }}}

" Colors {{{
syntax enable
"colorscheme grb256 " .vim/colors/*.vim
set t_Co=16
set background=dark
colorscheme solarized
hi NonText ctermbg=NONE


let g:airline_theme="solarized"
let g:airline_powerline_fonts = 1

hi Folded ctermbg=23
hi Folded ctermfg=255

" }}}

" Key commands {{{

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Vertical split
nnoremap <leader>w <C-w>v<C-w>l
" Horizontal split
nnoremap <leader>h <C-w>s<C-w>l

" j-k smash
inoremap jk <esc>
inoremap kj <esc>

" Save, yo
nnoremap <cr> :w<cr>

" Better command keys
nnoremap ; :

" Turn off nohlsearch
nmap <silent> <leader><Space> :nohlsearch<CR>

" Code folding with space
nnoremap <Space> za
vnoremap <Space> za

" Switch between files with ,,
nnoremap <leader><leader> <c-^>

" Fugitive
nnoremap <leader>g :G

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
" :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>

" Ruby hashrocket madness
nnoremap <leader>r :%s/:\(\w*\)\s*=>\s*/\1: /gc<cr>

" }}}

" Filetypes {{{

" Remove trailing whitespace in files
autocmd BufWritePre * :%s/\s\+$//e

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

augroup collumnLimit
  autocmd!
  autocmd BufEnter,WinEnter,FileType ruby
        \ highlight CollumnLimit ctermbg=DarkGrey guibg=DarkGrey
  let collumnLimit = 79 " feel free to customize
  let pattern =
        \ '\%<' . (collumnLimit+1) . 'v.\%>' . collumnLimit . 'v'
  autocmd BufEnter,WinEnter,FileType ruby
        \ let w:m1=matchadd('CollumnLimit', pattern, -1)
augroup END

" }}}

" Plugins {{{

"" Ignore rules

set wildignore+=*/tmp/*,*.so,*.swp,*.zip              " MacOSX/Linux
set wildignore+=*/node_modules/*,*/bower_components/* " Node.js
set wildignore+=*/vendor/*,*/dist/*                   " Meh

" Leader v for Rview
nnoremap <leader>v :Rview<Space>

" Surround
map <leader>s ysiw

" Rainbows!
" let g:rainbow_active = 1

" }}}

" Functions {{{

" Testing {{{

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUNNING TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! MapTest()
  nnoremap <leader>t :call RunTestFile()<cr>
endfunction
call MapTest()
nnoremap <leader>T :call RunNearestTest()<cr>
nnoremap <leader>a :call RunTests('')<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    if expand("%") != ""
      :w
    end
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        " First choice: project-specific test script
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        " Fall back to the .test-commands pipe if available, assuming someone
        " is reading the other side and running the commands
        elseif filewritable(".test-commands")
          let cmd = 'rspec --color --format progress --require "~/lib/vim_rspec_formatter" --format VimFormatter --out tmp/quickfix'
          exec ":!echo " . cmd . " " . a:filename . " > .test-commands"

          " Write an empty string to block until the command completes
          sleep 100m " milliseconds
          :!echo > .test-commands
          redraw!
        " Fall back to a blocking test run with Bundler
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        " Fall back to a normal blocking test run
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Selecta
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <c-p> :call SelectaCommand("ag --no-numbers --nogroup -l .", "", ":e")<cr>

" }}}
