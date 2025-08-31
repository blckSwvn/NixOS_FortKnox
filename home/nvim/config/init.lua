-- opts
vim.o.termguicolors = true
vim.loader.enable()
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

-- binds
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>g", ":FzfLua grep<CR>")
vim.keymap.set("n", "<leader>z", ":FzfLua <CR>")

vim.keymap.set("n", "<leader>o", ":lua MiniFiles.open()<CR>")

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.keymap.set("n", "<leader>q", ":q!<CR>")
vim.keymap.set("n", "<leader>x", ":x<CR>")

vim.keymap.set("n", "<leader>h", "<C-W>h")
vim.keymap.set("n", "<leader>j", "<C-W>j")
vim.keymap.set("n", "<leader>k", "<C-W>k")
vim.keymap.set("n", "<leader>l", "<C-W>l")

vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>c", ":split<CR>")

vim.cmd("command! Gs Git status")
vim.cmd("command! Gc Git commit")
vim.cmd("command! Gp Git push origin main")

vim.keymap.set("n", "<leader>Gp", ":Gitsigns preview_hunk<CR>")

--plugins
vim.pack.add({
	{src = "https://github.com/nvim-treesitter/nvim-treesitter"},
	{src = "https://github.com/windwp/nvim-autopairs"},
	--{src = "https://github.com/nyoom-engineering/oxocarbon.nvim"},
	{src = "https://github.com/ashish2508/Eezzy.nvim" },
	{src = "https://github.com/ibhagwan/fzf-lua"},
	{src = "https://github.com/nvim-tree/nvim-web-devicons"},
	{src = "https://github.com/lukas-reineke/indent-blankline.nvim"},
	{src = "https://github.com/hrsh7th/nvim-cmp"},
	{src = "https://github.com/hrsh7th/cmp-nvim-lsp"},
	{src = "https://github.com/neovim/nvim-lspconfig"},
	{src = "https://github.com/echasnovski/mini.nvim"},
	{src = "https://github.com/tpope/vim-fugitive"},
	{src = "https://github.com/lewis6991/gitsigns.nvim"},
	{src = "https://github.com/leath-dub/snipe.nvim"},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = {"c", "lua", "nix"},
	highlight = {enable = true},
})

require("nvim-autopairs").setup()
require("ibl").setup({
	scope = { enabled = true},
})

require("mini.files").setup({
	mappings = {
		synchronize = "W",
	},
	options = {
		permanent_delete = true,
		use_as_default_explorer = true,
	}
})

--vim.cmd.colorscheme("oxocarbon")
vim.cmd.colorscheme("Eezzy")

vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#ffffff", bg = nil })
vim.api.nvim_set_hl(0, "CmpBorder", { fg = "#ffffff", bg = nil })

local border = "rounded"

-- Override handlers to use borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = border }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = border }
)

-- Diagnostics float window border
vim.diagnostic.config({
  float = { border = border }
})

-- Make :LspInfo border match too (if you use it)
require("lspconfig.ui.windows").default_options.border = border
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gr", function()
		require("fzf-lua").lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

lspconfig.clangd.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}
lspconfig.nixd.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}
lspconfig.lua_ls.setup{
	capabilities = capabilities,
	on_attach = on_attach,
}


local cmp = require"cmp"
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(border),
		documentation = cmp.config.window.bordered(border),
	},
	snippet = {
		expand = function() end
	},
	mapping = {
		['<Tab>'] = cmp.mapping.confirm({ select = true }, {"i", "s"}),
		['<Esc>'] = cmp.mapping.abort(),
	},
	sources = {
		{name = "nvim_lsp"},
		{name = "buffer"},
		{name = "path"},
	},
	completion = {
		completeopt = 'menu,menuone,select'
	}
})



require("gitsigns").setup()

local snipe = require("snipe")
snipe.setup()
vim.keymap.set("n", "s", snipe.open_buffer_menu)
