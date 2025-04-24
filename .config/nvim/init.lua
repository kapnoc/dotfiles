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

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

-- style
Plug 'loctvl842/monokai-pro.nvim'
Plug 'eliseshaffer/darklight.nvim'

vim.call('plug#end')

-- nvim lsp
-- needed language servers:
-- npm install -g typescript typescript-language-server
-- npm i -g vscode-langservers-extracted
vim.lsp.enable('ts_ls')
-- vim.lsp.enable('eslint')
vim.lsp.enable('html')
vim.lsp.enable('jsonls')
vim.lsp.enable('rust_analyzer')

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "<leader>do", vim.lsp.buf.code_action, {})

-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

        -- For `mini.snippets` users:
        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
        -- insert({ body = args.body }) -- Insert at cursor
        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
        -- require("cmp.config").set_onetime({ sources = {} })
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['ts_ls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['html'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['jsonls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }


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
require("monokai-pro").setup({
  transparent_background = true,
  filter = "pro"
})
vim.cmd.colorscheme('monokai-pro')
vim.g.lightline = { colorscheme = 'monokaipro', mode_map = { n = 'N', i = 'I', R = 'R', v = 'V', V = 'VL', c = 'C', s = 'S', S = 'SL', t = 'T' }, active = { left = { { 'mode', 'paste' }, { 'readonly', 'relativepath', 'modified' } } } }
require('darklight').setup({
  mode = 'custom',
  light_mode_callback = function()
    require("monokai-pro").setup({
      transparent_background = false,
      filter = "light", -- classic | octagon | pro | machine | ristretto | spectrum
    })
  end,
  dark_mode_callback = function()
    require("monokai-pro").setup({
      transparent_background = true,
      filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
    })
  end
})
vim.cmd([[nmap <leader>dl :DarkLightSwitch<CR>]])


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

vim.cmd([[
autocmd Filetype lua setlocal ts=2 sw=2 expandtab
]])


-- TeX
vim.cmd([[nmap <leader>bb :!./build.sh<CR>]])
