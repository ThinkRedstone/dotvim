" ┌─────────────────────────────────────────┐
" │         VimFiles by Lucas Caton         │
" ├─────────────────────────────────────────┤
" | https://www.lucascaton.com.br/          |
" | https://github.com/lucascaton/vimfiles/ |
" └─────────────────────────────────────────┘

set nocompatible " Unleash all Vim power

" ┌───────────────────────────────────┐
" │     vim-plug (plugin manager)     │
" └───────────────────────────────────┘

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'andymass/vim-matchup'
Plug 'vim-airline/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'danro/rename.vim'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'gorkunov/smartpairs.vim'
" Plug 'henrik/vim-ruby-runner', { 'for': 'ruby' }
" Plug 'kchmck/vim-coffee-script', { 'for': 'coffeescript' }
Plug 'lilydjwg/colorizer'
Plug 'mileszs/ack.vim'
Plug 'msanders/snipmate.vim'
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'pangloss/vim-javascript'
Plug 'rstacruz/sparkup', { 'rtp': 'vim/' }
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-abolish'
" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-rails'
" Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-sensible'
Plug 'w0rp/ale'
Plug 'tpope/vim-surround'
Plug 'rust-lang/rust.vim'
Plug 'Rykka/riv.vim'
Plug 'preservim/nerdcommenter'
Plug 'bfrg/vim-qf-preview'
Plug 'jvirtanen/vim-hcl'
Plug 'luochen1990/rainbow'
Plug 'preservim/vim-markdown'

call plug#end()

let mapleader=","

inoremap <leader><leader> <Esc>
tnoremap <leader><leader> <c-w>N
nnoremap <leader>w :w<CR>
nnoremap <leader>t :tabe %<CR><C-O>
nnoremap <leader>z :tab term<CR>
nnoremap <leader>b :below term<CR>
nnoremap <leader>g :Git<CR>
nnoremap <c-j> gT
nnoremap <c-k> gt
nnoremap <leader>h :noh<CR> 
nnoremap <c-f> :NERDTreeFind<CR>
nnoremap <leader>c<space> :NERDCommenterToggle<CR>
nnoremap <leader>r :ALEFindReferences<CR>
nnoremap <leader>d :ALEHover<CR>
nnoremap <c-p> :Files<CR>

" Remove annoying colorizer map
let g:colorizer_nomap=1
let g:colorizer_maxlines=2000
let g:rainbow_active = 0

" ┌───────────────────────────────────┐
" │      Bind preview to ALE windows  │
" └───────────────────────────────────┘

augroup qfpreview
    autocmd!
    autocmd FileType ale-preview-selection nmap <buffer> p <plug>(qf-preview-open)
    autocmd FileType qf nmap <buffer> p <plug>(qf-preview-open)
augroup END

let g:riv_fold_auto_update = 0
let g:rustfmt_autosave = 1
set spell spelllang=en_us
set list

" ┌───────────────────────────────────┐
" │      Plugins customizations       │
" └───────────────────────────────────┘

" NERDTree
nmap <F2> :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
let NERDTreeIgnore = [
  \'\.DS_Store$',
  \'\.bundle$',
  \'\.capistrano$',
  \'\.git$',
  \'\.gitkeep$',
  \'\.keep$',
  \'\.localized$',
  \'\.routes$',
  \'\.sass-cache$',
  \'\.swo$',
  \'\.swp$',
  \'tags$'
\]

" Ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Tabular
inoremap <silent> <Bar> <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

if exists(":Tabularize")
  nmap <Leader>t= :Tabularize /=<CR>
  vmap <Leader>t= :Tabularize /=<CR>
  nmap <Leader>t> :Tabularize /=><CR>
  vmap <Leader>t> :Tabularize /=><CR>
  nmap <Leader>t: :Tabularize /:\zs<CR>
  vmap <Leader>t: :Tabularize /:\zs<CR>
endif

" CtrlP
let g:ctrlp_use_caching = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules$',
  \ 'file': '\v\.(exe|so|dll|.DS_Store)$',
  \ }

" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='dark'

" vim-jsx
let g:jsx_ext_required = 0

" ALE
let g:ale_rust_analyzer_executable="/home/dafner/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer"
let g:ale_linters = {'rust': ['analyzer'], 'python': ['pyright']}
let g:ale_floating_preview=1
let g:ale_python_auto_virtualenv=1
set completeopt=menu,popup

" highlight clear ALEErrorSign
" highlight clear ALEWarningSign

" ┌───────────────────────────────────┐
" │             Settings              │
" └───────────────────────────────────┘

" ALE settings

function! s:bind_ale()
  setlocal omnifunc=ale#completion#OmniFunc
  inoremap <buffer><C-p> <C-x><C-O>
  nnoremap <buffer><C-]> :ALEGoToDefinition<cr>
endfunction

autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css        set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php        set omnifunc=phpcomplete#CompletePHP
autocmd FileType c          set omnifunc=ccomplete#Complete

autocmd FileType rust call s:bind_ale()
autocmd FileType python call s:bind_ale()

autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

" Disables balloonexpr - more info: https://github.com/w0rp/ale/issues/1669
autocmd FileType ruby,eruby set noballooneval

" Set text width for MarkDown files
autocmd FileType markdown set textwidth=80

" Make terminals always have no numbering
autocmd TerminalWinOpen * setlocal nonumber norelativenumber

" Autoindent with two spaces, always expand tabs
set tabstop=2
set shiftwidth=2
set expandtab

" Folding settings
set nofoldenable

set wildmode=list:longest " make cmdline tab completion similar to bash
set wildignore=*.o,*.obj,*~ " stuff to ignore when tab completing

" Horizontal scroll settings
" FIXME: Remove it when this gets merged: https://github.com/tpope/vim-sensible/pull/124
set sidescroll=1

set cf " Enable error files & error jumping.
set clipboard+=unnamed " Yanks go on clipboard instead.
set autowrite " Writes on make/shell commands
set nu " Line numbers on
set wrap " Line wrapping on

" Highlight all search results
set hlsearch

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Forcing the use of hjkl keys to navigate
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>
" inoremap <Up> <nop>
" inoremap <Down> <nop>
" inoremap <Left> <nop>
" inoremap <Right> <nop>

" Highlight long lines
" let w:m2=matchadd('Search',   '\%>100v.\+', -1)
" let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)

" Relative line numbers in normal mode
" set rnu
" au InsertEnter * :set nu
" au InsertLeave * :set rnu
" au FocusLost * :set nu
" au FocusGained * :set rnu

" Ignore case in searches
set ignorecase

" Open splits at right side (and below)
set splitright
" set splitbelow

" Never ever let Vim write a backup file! They did that in the 70’s.
" Use modern ways for tracking your changes (like git), for God’s sake
set nobackup
set noswapfile

" ┌───────────────────────────────────┐
" │               Theme               │
" └───────────────────────────────────┘

" Fonts for Linux
" set guifont=Bitstream\ Vera\ Sans\ Mono\ 9
" set guifont=Monospace\ 10

" Fonts for Mac
" set guifont=Monaco\ for\ Powerline:h15
" set guifont=Roboto\ Mono\ for\ Powerline:h15
set guifont=Hack\ Regular\ Nerd\ Font\ Complete:h15

" Don't show the top bar
set guioptions-=T

set listchars=tab:»·,trail:·,extends:>,precedes:<,nbsp:+

if has("gui_running")
  set lines=57
  set columns=237
  set colorcolumn=100

  " Highlight the line and the column of the current position of cursor
  set cursorline
  set cursorcolumn
  hi CursorLine guibg=#222222
  hi CursorColumn guibg=#222222
endif

if has("gui_running") || $TERM == "xterm-256color"
  set t_Co=256
  let base16colorspace=256 " Access colors present in 256 colorspace
  " colorscheme base16-default-dark
  colorscheme base16-ocean
  colorscheme gruvbox
  hi SpellBad ctermul=red cterm=underline
else
  let g:CSApprox_loaded = 0
endif

" ┌───────────────────────────────────┐
" │             Functions             │
" └───────────────────────────────────┘

" Removes trailing spaces
function TrimWhiteSpace()
  %s/\s*$//
  ''
:endfunction

map  <leader>= :call TrimWhiteSpace()<CR>
map! <leader>= :call TrimWhiteSpace()<CR>

" Removes trailing spaces before saving
" autocmd BufWritePre * :%s/\s\+$//e

" Add `{:target='_blank'}` to MarkDown links
function AddTargetBlankToMarkDownLiks()
  %s/\(\[.\+\](.\{-})\)/\1{:target='_blank'}/gc
  ''
:endfunction

map <leader>l :call AddTargetBlankToMarkDownLiks()<CR>

" Adds space between hash content and braces
function AddsSpaceBetweenHashContentAndBraces()
  silent! s/{\([^ ]\)/{ \1/
  silent! s/\([^ ]\)}/\1 }/
  ''
:endfunction

map  <leader>{ :call AddsSpaceBetweenHashContentAndBraces()<CR>
map! <leader>{ :call AddsSpaceBetweenHashContentAndBraces()<CR>

" Collapse multiple blank lines (regardless of quantity) into a single blank line.
function CollapseMultipleBlankLines()
  g/^\_$\n\_^$/d
  ''
:endfunction

map  <leader>- :call CollapseMultipleBlankLines()<CR>
map! <leader>- :call CollapseMultipleBlankLines()<CR>

" Invert lines
function InvertLines()
  g/^/m0
  ''
:endfunction

nnoremap <D-i> :call InvertLines()<cr>

" Convert Ruby 1.8 to 1.9 Hash Syntax
" http://robots.thoughtbot.com/convert-ruby-1-8-to-1-9-hash-syntax
function ConvertRubyHashSyntax()
  %s/:\([^ ]*\)\(\s*\)=>/\1:/g
  ''
:endfunction

" nnoremap <leader>h :call ConvertRubyHashSyntax()<cr>

" Global Search (Ack/Ag) shortcut
if has("macunix") " macOS
  " Cmd + Shift + F
  nnoremap <D-F> :Ack -i<SPACE>
else
  " Ctrl + Shift + F
"  nnoremap <C-F> :Ack -i<SPACE>
endif

" Bind K to search for the word under cursor
nnoremap K :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>

" Auto complete
let g:stop_autocomplete=0

function! CleverTab(type)
  if a:type=='omni'
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
      let g:stop_autocomplete=1
      return "\<TAB>"
    elseif !pumvisible() && !&omnifunc
      return "\<C-X>\<C-O>\<C-P>"
    endif
  elseif a:type=='keyword' && !pumvisible() && !g:stop_autocomplete
    return "\<C-X>\<C-N>\<C-P>"
  elseif a:type=='next'
    if g:stop_autocomplete
      let g:stop_autocomplete=0
    else
      return "\<C-N>"
    endif
  endif
  return ''
endfunction

inoremap <silent><TAB> <C-R>=CleverTab('omni')<CR><C-R>=CleverTab('keyword')<CR><C-R>=CleverTab('next')<CR>

" Tab toggle
function TabToggle()
  if &expandtab
    set noexpandtab
  else
    set expandtab
  endif
  retab!
endfunction
nmap <F9> mz:execute TabToggle()<CR>

" RSpec focus
function! s:Preserve(command)
  " Save cursor position
  let l = line(".")
  let c = col(".")

  " Do the business
  execute a:command

  " Restore cursor position
  call cursor(l, c)
  " Remove search history pollution and restore last search
  call histdel("search", -1)
  let @/ = histget("search", -1)
endfunction

function! s:AddFocusTag()
  call s:Preserve("normal! ^ / do$\<cr>C, focus: true do\<esc>")
endfunction
:nnoremap <leader>a :AddFocusTag<CR>
command! -nargs=0 AddFocusTag call s:AddFocusTag()

function! UseSingleQuotes()
  execute ":%s/\"/'/g"
endfunction
map <Leader>' :call UseSingleQuotes()<CR>

function! UseDoubleQuotes()
  execute ":%s/'/\"/g"
endfunction
map <Leader>" :call UseDoubleQuotes()<CR>

function! OpenGemfile()
  if filereadable("Gemfile")
    execute ":tab drop Gemfile"
  end
endfunction
" map <Leader>g :call OpenGemfile()<CR>

function! OpenGemfileLock()
  if filereadable("Gemfile.lock")
    execute ":tab drop Gemfile.lock"
  end
endfunction
map <Leader>G :call OpenGemfileLock()<CR>

function! OpenReadme()
  if filereadable("README.md")
    execute ":tab drop README.md"
  else
    if filereadable("README.rdoc")
      execute ":tab drop README.rdoc"
    else
      if filereadable("README")
        execute ":tab drop README"
      end
    end
  end
endfunction
map <Leader>R :call OpenReadme()<CR>

function! OpenSpecHelper()
  if filereadable("spec/spec_helper.rb")
    execute ":tab drop spec/spec_helper.rb"
  end
endfunction
map <Leader>s :call OpenSpecHelper()<CR>

map <Leader>v :tab drop $MYVIMRC<CR>
" map <Leader>z :tab drop ~/.zshrc<CR>
map <Leader>pc :tab drop ~/Dropbox/.personal_configs/aliases_and_functions.sh<CR>

" Search and replace selected text (http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text)
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Mapping Y to yank from current cursor position till end of line
noremap Y y$


" Creates parent directories on save
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
" augroup BWCCreateDir
"   autocmd!
"   autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
" augroup END

" Comment out current line or selected text (maintaining visual mode after it)
vmap <D-/> gcgv
nmap <D-/> gcc

function! s:get_visual_selection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

function! s:selection_DB()
    let selection = s:get_visual_selection()
    execute "DB" selection
endfunction

command! -range -nargs=0 SDB call s:selection_DB()

command! Staging let b:db="postgresql://postgres@staging-database.cwr5toyofssk.us-east-1.rds.amazonaws.com:5432/postgres"

nnoremap <leader>f :.DB<CR>
vnoremap <leader>f :SDB<CR>

" ┌───────────────────────────────────┐
" │             Shortcuts             │
" └───────────────────────────────────┘

"" Set working directory
"nnoremap <leader>. :lcd %:p:h<CR>

" Ctrl+R reloads the vimrc file
nnoremap <F12> :source $MYVIMRC

" Improve 'n' command (for searches)
nmap n nzz
nmap N Nzz

" Improve 'gf' command (go to file) - make it open in a new tab
nmap gf <C-w>gf

" Mappings to move lines: http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <D-j> :m .+1<CR>==
nnoremap <D-k> :m .-2<CR>==
inoremap <D-j> <Esc>:m .+1<CR>==gi
inoremap <D-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" A trick for when you forgot to sudo before editing a file that requires root privileges (typically /etc/hosts).
" This lets you use w!! to do that after you opened the file already:
" More info: https://dev.to/jovica/the-vim-trick-which-will-save-your-time-and-nerves-45pg
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Sets Q to apply @q macros
nnoremap Q @q
vnoremap Q :norm @q<cr>

" Adds a `puts` for code inspection (Ruby language)
noremap <leader>p yypk^<Esc>iputs "#{'-' * `tput cols`.to_i}\n<Esc>$a: #{<Esc>Jx$a.inspect}\n#{'-' * `tput cols`.to_i}"<Esc>

" ┌───────────────────────────────────┐
" │     Shortcuts for Linux (Gvim)    │
" └───────────────────────────────────┘

" Ctrl+C to copy and Ctrl+P to paste
" vnoremap <C-C> "+y
" inoremap <C-P> <ESC>"+pa
" nnoremap <C-P> "+p

" Ctrl+S to save the current file
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>

" Management tabs
nnoremap <C-t> :tabnew<cr>
nnoremap <C-T> :tabnew<cr>
nnoremap <A-w> :q<cr>
nnoremap <A-W> :q<cr>

" ┌───────────────────────────────────┐
" │              Aliases              │
" └───────────────────────────────────┘

cab W w
cab Q q
cab Wq wq
cab wQ wq
cab WQ wq
cab t tab drop
cab T tab drop
cab tabe tab drop
cab Tabe tab drop
cab E e

" ┌───────────────────────────────────┐
" │        Syntax Highlighting        │
" └───────────────────────────────────┘

au BufNewFile,BufRead Guardfile    set filetype=ruby
au BufNewFile,BufRead Vagrantfile  set filetype=ruby
au BufNewFile,BufRead Capfile      set filetype=ruby
au BufNewFile,BufRead Podfile      set filetype=ruby
au BufNewFile,BufRead Brewfile     set filetype=ruby
au BufNewFile,BufRead *.thor       set filetype=ruby
au BufNewFile,BufRead .pryrc       set filetype=ruby
au BufNewFile,BufRead pryrc        set filetype=ruby
au BufNewFile,BufRead *.pp         set filetype=ruby
au BufNewFile,BufRead *.prawn      set filetype=ruby
au BufNewFile,BufRead Appraisals   set filetype=ruby
au BufNewFile,BufRead *.rabl       set filetype=ruby
au BufNewFile,BufRead *.cr         set filetype=ruby " Crystal
au BufNewFile,BufRead .psqlrc      set filetype=sql
au BufNewFile,BufRead psqlrc       set filetype=sql
au BufNewFile,BufRead *.less       set filetype=css
au BufNewFile,BufRead bash_profile set filetype=sh
au BufNewFile,BufRead *.hbs        set filetype=html
au BufNewFile,BufRead *.yml.sample set filetype=yaml
au BufNewFile,BufRead .env.*       set filetype=sh
au BufNewFile,BufRead *.cson       set filetype=coffee " Same as JSON but for CoffeeScript objects
au BufNewFile,BufRead .babelrc     set filetype=javascript
au BufNewFile,BufRead *.js.snap    set filetype=jsx
au BufNewFile,BufRead brakeman.ignore set filetype=json

" Git hooks
au BufNewFile,BufRead applypatch-msg     set filetype=ruby
au BufNewFile,BufRead commit-msg         set filetype=ruby
au BufNewFile,BufRead post-update        set filetype=ruby
au BufNewFile,BufRead pre-applypatch     set filetype=ruby
au BufNewFile,BufRead pre-commit         set filetype=ruby
au BufNewFile,BufRead pre-push           set filetype=ruby
au BufNewFile,BufRead pre-rebase         set filetype=ruby
au BufNewFile,BufRead prepare-commit-msg set filetype=ruby

" ┌───────────────────────────────────┐
" │   Project Specific .vimrc Files   │
" └───────────────────────────────────┘

" https://andrew.stwrt.ca/posts/project-specific-vimrc/

set exrc
set secure
