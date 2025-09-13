-- OPTIONS
vim.o.termguicolors = true
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
map("n", "<leader>t", ":tabnew<CR>")
vim.cmd("command! Gs Git status")
vim.cmd("command! Gc Git commit")
vim.cmd("command! Gp Git push origin main")
map("t", "<C-Space>", [[<C-\><C-n>]])

-- PACKS
vim.pack.add({
	{src = "https://github.com/nvim-treesitter/nvim-treesitter"},
	{src = "https://github.com/stevearc/oil.nvim"},
	{src = "https://github.com/windwp/nvim-autopairs"},
	{src = "https://github.com/ibhagwan/fzf-lua"},
	{src = "https://github.com/nvim-tree/nvim-web-devicons"},
	{src = "https://github.com/lukas-reineke/indent-blankline.nvim"},
	{src = "https://github.com/hrsh7th/nvim-cmp"},
	{src = "https://github.com/hrsh7th/cmp-nvim-lsp"},
	{src = "https://github.com/neovim/nvim-lspconfig"},
	{src = "https://github.com/tpope/vim-fugitive"},
	{src = "https://github.com/lewis6991/gitsigns.nvim"},
	{src = "https://github.com/leath-dub/snipe.nvim"},
	{src = "https://github.com/rebelot/heirline.nvim"},
	{src = "https://github.com/rktjmp/lush.nvim"},
	{src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"},
})

-- PLUGIN CONFIGS
require("oil").setup()

require'nvim-treesitter.configs'.setup {
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
}

require("nvim-treesitter.configs").setup({
	ensure_installed = {"c", "lua", "nix"},
	highlight = {enable = true},
})

require("nvim-autopairs").setup()
require("ibl").setup({ scope = { enabled = true } })

require("gitsigns").setup()
require("snipe").setup()
map("n", "s", require("snipe").open_buffer_menu)

-- LSP CONFIG
local border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
vim.diagnostic.config({ float = { border = border } })
require("lspconfig.ui.windows").default_options.border = border

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr }
	map("n", "gd", vim.lsp.buf.definition, opts)
	map("n", "K", vim.lsp.buf.hover, opts)
	map("n", "gr", function() require("fzf-lua").lsp_references() end, opts)
	map("n", "<leader>rn", vim.lsp.buf.rename, opts)
	map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

lspconfig.clangd.setup{ capabilities = capabilities, on_attach = on_attach }
lspconfig.nixd.setup{ capabilities = capabilities, on_attach = on_attach }
lspconfig.lua_ls.setup{ capabilities = capabilities, on_attach = on_attach }

-- CMP CONFIG
local cmp = require("cmp")
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(border),
		documentation = cmp.config.window.bordered(border),
	},
	snippet = { expand = function() end },
	mapping = {
		['<Tab>'] = cmp.mapping.confirm({ select = true }, {"i","s"}),
		['<Esc>'] = cmp.mapping.abort(),
	},
	sources = { {name="nvim_lsp"}, {name="buffer"}, {name="path"} },
	completion = { completeopt='menu,menuone,select' }
})

-- LUSH THEME
local lush = require("lush")

local palette = {
	bg        = "#000005",
	fg        = "#DADADA",

	-- Normal 8
	black     = "#303030",
	red       = "#DB1200",
	green     = "#4EC24A",   -- tweaked to feel fresher & consistent
	yellow    = "#f0bf00",
	blue      = "#4472CA",
	magenta   = "#B85AF2",
	cyan      = "#3FC8B3",
	white     = "#E0E0E0",

	-- Bright 8
	bright_black   = "#5C5C5C",
	bright_red     = "#FF4040",  -- softened from neon pink, still strong
	bright_green   = "#78E06B",  -- true lighter green
	bright_yellow  = "#FFD75A",  -- brighter golden yellow
	bright_blue    = "#6CA8FF",  -- lighter, modern blue
	bright_magenta = "#D49BFF",  -- softer purple-pink
	bright_cyan    = "#7FE9DB",  -- more distinct from base cyan
	bright_white   = "#FFFFFF",
}

local theme = lush(function()
	return {
		Normal      { fg = palette.fg, bg = palette.bg },
		Cursor      { fg = palette.bg, bg = palette.fg },
		Visual      { bg = palette.black },
		Comment     { fg = palette.bright_black, gui = "italic" },

		-- Language
		String      { fg = palette.green },
		Number      { fg = palette.cyan },            -- cooler than yellow
		Boolean     { fg = palette.magenta },         -- abstract concepts
		Constant    { fg = palette.cyan },
		Type        { fg = palette.green },
		Keyword     { fg = palette.yellow },          -- control / definition
		Conditional { fg = palette.yellow },          -- if/else, etc.
		Statement   { fg = palette.red, gui = "bold" },
		Function    { fg = palette.blue },
		Identifier  { fg = palette.blue },

		-- Operators and misc
		Operator    { fg = palette.fg },              -- neutral, avoids rainbow
		PreProc     { fg = palette.bright_yellow },   -- #includes, macros
		Special     { fg = palette.bright_cyan },     -- escape chars, regex, unusual

		-- UI
		Directory   { fg = palette.blue },
		Error       { fg = palette.bright_red, gui = "bold" },
		WarningMsg  { fg = palette.bright_yellow, gui = "bold" },
		Info        { fg = palette.bright_blue },
		Todo        { fg = palette.bright_yellow, gui = "bold,italic" },

		CursorLine  { bg = palette.black },
		StatusLine  { fg = palette.fg, bg = palette.black },
		StatusLineNC{ fg = palette.bright_black, bg = palette.black },

		DiagnosticError { fg = palette.bright_red },
		DiagnosticWarn  { fg = palette.bright_yellow },
		DiagnosticInfo  { fg = palette.blue },
		DiagnosticHint  { fg = palette.cyan },
	}
end)

lush(theme)

vim.o.laststatus = 2

vim.o.statusline = "%f %m %= %{v:lua.GitStatus()}  %l/%L:%c"

_G.GitStatus = function()
    local gsd = vim.b.gitsigns_status_dict
    if not gsd then return "" end
    local s = "" .. gsd.head
    if gsd.added ~= 0 then s = s .. " +" .. gsd.added end
    if gsd.removed ~= 0 then s = s .. " -" .. gsd.removed end
    if gsd.changed ~= 0 then s = s .. " ~" .. gsd.changed end
    return s
end
vim.api.nvim_set_hl(0, "StatusLine",   { fg = palette.fg, bg = palette.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "VertSplit",    { fg = palette.black, bg = palette.bg })
