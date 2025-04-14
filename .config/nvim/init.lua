local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'

Plug 'ibhagwan/fzf-lua'

Plug 'itchyny/lightline.vim'

-- js/ts/...
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

-- html
Plug 'mattn/emmet-vim'

Plug('neoclide/coc.nvim', {['branch'] = 'release'})

-- style
Plug 'loctvl842/monokai-pro.nvim'

vim.call('plug#end')


vim.g.coc_global_extensions = { 'coc-tsserver', 'coc-html', 'coc-json', 'coc-pyright' }

-- coc
vim.cmd([[if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif]])

-- disabled eslint in favor of xo
vim.cmd([[if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif]])

-- coc shortcuts
vim.cmd([[inoremap <silent><expr> <C-y>y coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]])
vim.cmd([[nnoremap <silent> gK :call CocAction('doHover')<CR>]])
vim.cmd([[nmap <silent> gd <Plug>(coc-definition)]])
vim.cmd([[nmap <silent> gy <Plug>(coc-type-definition)]])
vim.cmd([[nmap <silent> gr <Plug>(coc-references)]])
vim.cmd([[nmap <silent> [g <Plug>(coc-diagnostic-prev)]])
vim.cmd([[nmap <silent> ]g <Plug>(coc-diagnostic-next)]])
vim.cmd([[nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>]])
vim.cmd([[nnoremap <silent> <space>s :<C-u>CocList -I symbols<cr>]])
vim.cmd([[nmap <leader>do <Plug>(coc-codeaction)]])
vim.cmd([[nmap <leader>rn <Plug>(coc-rename)]])
vim.cmd([[nmap <leader>xo :!npx xo --fix %<CR>]])


local fzflua = require('fzf-lua')
fzflua.setup{
	files = {
		find_opts = [[\( -path "*/build/*" -o -path "*/.git/*" -o -path "*/node_modules/*" \) -prune -false -o -type f]],
		fd_opts = [[--color=never --hidden --type f --type l --exclude "(.git|node_modules)"]],
	},
	grep = {
		grep_opts = [[--exclude-dir=node_modules --exclude-dir=build --exclude-dir=.git --binary-files=without-match --line-number --recursive --color=auto -e]],
		rg_opts = [[--glob '!{**/node_modules/,**/build/,.git/} --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e']]
	}
}
vim.keymap.set('n', '<leader>ff', fzflua.files, { desc = 'fzf-lua find files' })
vim.keymap.set('n', '<leader>fg', fzflua.live_grep, { desc = 'fzf-lua live grep' })
vim.keymap.set('n', '<leader>fb', fzflua.buffers, { desc = 'fzf-lua buffers' })

-- style
vim.g.t_Co = 256
vim.cmd.colorscheme('monokai-pro-light')
vim.g.lightline = { colorscheme = 'monokaipro', mode_map = { n = 'N', i = 'I', R = 'R', v = 'V', V = 'VL', c = 'C', s = 'S', S = 'SL', t = 'T' }, active = { left = { { 'mode', 'paste' }, { 'readonly', 'relativepath', 'modified' } } } }

-- select last paste in visual mode
vim.cmd([[nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]']])

vim.bo.undofile=true

vim.cmd([[
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" js/ts/...
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 expandtab
autocmd Filetype json setlocal ts=2 sw=2 expandtab
autocmd Filetype typescriptreact setlocal ts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype htmldjango setlocal ts=2 sw=2 expandtab
autocmd Filetype scss setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sts=4 sw=4 expandtab
]])







