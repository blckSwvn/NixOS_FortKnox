-- OPTIONS
vim.o.termguicolors = true
vim.o.ignorecase = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.shiftwidth = 8
vim.o.tabstop = 8
vim.o.expandtab = false
vim.o.smartindent = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.opt.clipboard = "unnamedplus"

vim.cmd('filetype plugin indent on')

-- LEADER
vim.g.mapleader = " "

-- KEYBINDINGS
local map = vim.keymap.set
map("n", "<leader>g", ":FzfLua grep<CR>")
map("n", "<leader>f", ":FzfLua files<CR>")
map("n", "<leader>m", ":FzfLua marks<CR>")
map("n", "<leader>z", ":FzfLua <CR>")
map("n", "<leader>-", ":Oil <CR>")
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q!<CR>")
map("n", "<leader>x", ":x<CR>")
map("n", "<leader>h", "<C-W>h")
map("n", "<leader>j", "<C-W>j")
map("n", "<leader>k", "<C-W>k")
map("n", "<leader>l", "<C-W>l")
map("n", "<leader>v", ":vsplit<CR>")
map("n", "<leader>c", ":split<CR>")
map("n", "<leader>n", ":tabnew<CR>")
map("n", "<leader>t", ":terminal<CR>")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("t", "<C-Space>", [[<C-\><C-n>]])

vim.api.nvim_create_autocmd("VimEnter",{
callback = function ()
	vim.cmd("r !fortune | cowsay ")
	vim.bo.buftype = "nofile"
	vim.bo.modifiable = false
	vim.bo.readonly = true
	vim.cmd("normal! ggzz")
end
})

-- PACKS
vim.pack.add({
	{src = "https://github.com/nvim-treesitter/nvim-treesitter"},
	{src = "https://github.com/stevearc/oil.nvim"},
	{src = "https://github.com/windwp/nvim-autopairs"},
	{src = "https://github.com/ibhagwan/fzf-lua"},
	{src = "https://github.com/nvim-tree/nvim-web-devicons"},
	{src = "https://github.com/hrsh7th/nvim-cmp"},
	{src = "https://github.com/hrsh7th/cmp-nvim-lsp"},
	{src = "https://github.com/L3MON4D3/LuaSnip"},
	{src = "https://github.com/neovim/nvim-lspconfig"},
	{src = "https://github.com/tpope/vim-fugitive"},
	{src = "https://github.com/lewis6991/gitsigns.nvim"},
	{src = "https://github.com/leath-dub/snipe.nvim"},
	{src = "https://github.com/rktjmp/lush.nvim"},
	{src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"},
	{src = "https://github.com/chentoast/marks.nvim"},
})

-- PLUGIN CONFIGS
require("oil").setup({
	columns = {
		"mtime",
		"icon",
	},
	view_options = {
		show_hidden = false,
		sort = {
			{ "mtime", "desc" },
			{ "name", "asc" },
		},
	},
	watch_for_changes = true,
})

require("nvim-treesitter.configs").setup({
  ensure_installed = { "c", "lua", "nix", "css" },
  highlight = { enable = true },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
})

require("nvim-autopairs").setup()

require("gitsigns").setup()
require("snipe").setup()
map("n", "s", require("snipe").open_buffer_menu)

-- LSP CONFIG
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.diagnostic.config({ float = { border = "rounded" } })

-- Optional: load snippets from VSCode style
require("luasnip.loaders.from_vscode").lazy_load()

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" }
}


local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "gr", function() require("fzf-lua").lsp_references() end, opts)
    map("n", "y", vim.lsp.buf.rename, opts)
    map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- Server configs
local servers = {
    clangd = {},
    lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim" } } } } },
    nixd = {},
    cssls = {}
}

for name, config in pairs(servers) do
    config.capabilities = capabilities
    config.on_attach = on_attach
    vim.lsp.config[name] = config
end

-- CMP CONFIG
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)  -- enable snippet expansion for LSP
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping.confirm({ select = true }, {"i", "s"}),  -- only confirm
        ["<Esc>"] = cmp.mapping.abort(),                     -- abort
    },
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },  -- keep snippets as a source
    },
    window = {
	    completion = cmp.config.window.bordered("rounded"),
	    documentation = cmp.config.window.bordered("rounded"),
    },
    completion = { completeopt = "menu,menuone,select" },
})

-- LUSH THEME
local lush = require("lush")

local grays = {
	fg    = "#DADADA",
	bg    = "#000000",
	black   = "#202020",
	b_black = "#505050",
}

local colors = {
	green     = "#2db64A",   -- tweaked to feel fresher & consistent
	yellow    = "#f0bf00",
	blue      = "#4472CA",
	cyan      = "#3FC8B3",
	red       = "#DA2C38",
}

local theme = lush(function()
	return {
		CursorLine  { bg = grays.black},
		Visual      { bg = grays.black},
		Normal      { fg = grays.fg, bg = grays.bg },
		Cursor      { fg = grays.bg, bg = grays.fg },
		Comment     { fg = grays.b_black, gui = "italic" },

		-- Language
		String      { fg = colors.green},
		Boolean     { fg = colors.green},         -- true false
		Constant    { fg = colors.green},
		Number      { fg = colors.cyan},            -- cooler than yellow
		Type        { fg = colors.cyan},
		Keyword     { fg = colors.yellow},
		PreProc     { fg = colors.yellow},   -- #includes, macros
		Conditional { fg = colors.blue},          -- if/else, etc.
		Function    { fg = colors.blue},
		Identifier  { fg = grays.fg},

		-- Operators and misc
		Operator    { fg = grays.fg },              -- neutral, avoids rainbow
		Special     { fg = grays.fg},     -- escape chars, regex, unusual

		-- UI
		Directory   { fg = colors.blue },
		Error       { fg = colors.red, gui = "bold" },
		WarningMsg  { fg = colors.yellow, gui = "bold" },
		Info        { fg = grays.fg},

		StatusLine  { fg = grays.fg, bg = colors.black },
		StatusLineNC{ fg = grays.b_black, bg = grays.black },

		DiagnosticError { fg = colors.yellow},
		DiagnosticWarn  { fg = colors.yellow},
		DiagnosticInfo  { fg = colors.blue },
		DiagnosticHint  { fg = colors.cyan },
	}
end)

require'marks'.setup {
	default_mappings = true,
	force_write_shada = true,
	refresh_interval = 250,
}

lush(theme)
vim.api.nvim_set_hl(0, "MarkSignHL", {fg = colors.red, bg = grays.bg})
vim.api.nvim_set_hl(0, "StatusLine",   { fg = grays.fg, bg = grays.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = grays.fg, bg = grays.bg })
vim.api.nvim_set_hl(0, "VertSplit",    { fg = grays.black, bg = grays.bg })

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        -- Only start an LSP if one isn't already attached
        if not next(vim.lsp.get_active_clients({ bufnr = 0 })) then
            vim.cmd("LspStart")
        end
    end,
})
