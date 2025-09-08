-- OPTIONS
vim.o.winbar = nil
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

vim.cmd('filetype plugin indent on')

-- LEADER
vim.g.mapleader = " "

-- KEYBINDINGS
local map = vim.keymap.set
map("n", "<leader>g", ":FzfLua grep<CR>")
map("n", "<leader>z", ":FzfLua <CR>")
map("n", "<leader>o", ":lua MiniFiles.open()<CR>")
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
map("n", "<leader>Gp", ":Gitsigns preview_hunk<CR>")
map("n", "<leader>ct", ":ColorizerToggle<CR>")
map("t", "<C-Space>", [[<C-\><C-n>]])

-- PACKS
vim.pack.add({
	{src = "https://github.com/nvim-treesitter/nvim-treesitter"},
	{src = "https://github.com/windwp/nvim-autopairs"},
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
	{src = "https://github.com/rebelot/heirline.nvim"},
	{src = "https://github.com/rktjmp/lush.nvim"},
})

-- PLUGIN CONFIGS

require("nvim-treesitter.configs").setup({
	ensure_installed = {"c", "lua", "nix"},
	highlight = {enable = true},
})

require("nvim-autopairs").setup()
require("ibl").setup({ scope = { enabled = true } })

require("mini.files").setup({
	mappings = { synchronize = "W" },
	options = { permanent_delete = true, use_as_default_explorer = true }
})

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

-- HEIRLINE STATUSBAR
local heirline = require("heirline")
local devicons = require("nvim-web-devicons")

local colors = {
	white = palette.fg,
	normal = palette.bg,
	status = palette.black,
	string = palette.green,
	type   = palette.yellow,
	error  = palette.red,
	warn   = palette.bright_yellow,
}
heirline.load_colors(colors)

-- ViMode block
local ViMode = {
	init = function(self) self.mode = vim.fn.mode(1) end,
	static = {
		names = { n="NORMAL", i="INSERT", v="VISUAL", V="V-LINE", ["\22"]="V-BLOCK", R="REPLACE", c="CMD", t="TERM" },
		cols  = { n="white", i="string", v="type", V="type", ["\22"]="type", R="error", c="warn", t="string" },
	},
	provider = function(self) return " " .. self.names[self.mode] .. " " end,
	hl = function(self) return { fg=colors.normal, bg=colors[self.cols[self.mode]], bold=true } end,
}

-- File info
local FileDir = {
	provider = function()
		local filepath = vim.api.nvim_buf_get_name(0)
		return " " .. vim.fn.fnamemodify(filepath, ":.:h") .. "/"
	end,
}
local FileName = { provider = " %t ", hl = { fg = palette.yellow, bg = colors.normal } }

local FileType = {
	init = function(self)
		self.ft = vim.bo.filetype
		self.icon, self.icon_color = devicons.get_icon_color_by_filetype(self.ft, { default = true })
	end,
	provider = function(self) return " " .. self.icon .. " " end,
	hl = function(self) return { fg = self.icon_color, bg = colors.normal } end,
}

local function get_ahead_behind()
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir == "" then
		return ""
	end

	-- Get upstream info
	local upstream = vim.fn.systemlist("git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null")[1]
	if not upstream or upstream == "" then
		return ""
	end

	local counts = vim.fn.systemlist(
		"git rev-list --left-right --count HEAD..." .. upstream .. " 2>/dev/null"
	)[1]

	if not counts or counts == "" then
		return ""
	end

	local ahead, behind = counts:match("(%d+)%s+(%d+)")
	ahead, behind = tonumber(ahead), tonumber(behind)

	local result = {}
	if ahead > 0 then
		table.insert(result, "↑" .. ahead)
	end
	if behind > 0 then
		table.insert(result, "↓" .. behind)
	end

	return #result > 0 and table.concat(result, " ") or ""
end

local GitAheadBehind = {
	provider = function()
		return get_ahead_behind()
	end,
	hl = { fg = palette.cyan }, -- tweak highlight group
}

-- Git info
local Git = {
	condition = function() return vim.b.gitsigns_status_dict ~= nil end,
	init = function(self)
		self.status_dict = vim.b.gitsigns_status_dict
		self.has_changes = self.status_dict.added ~= 0
		or self.status_dict.removed ~= 0
		or self.status_dict.changed ~= 0
	end,
	hl = { fg = colors.string, bg = colors.normal },
	{
		provider = function(self) return "" .. self.status_dict.head .. " " end,
		hl = { bold = true }
	},
	{
		provider = function(self)
			local s = ""
			if self.status_dict.added ~= 0 then s = s .. "+" .. self.status_dict.added .. " " end
			if self.status_dict.removed ~= 0 then s = s .. "-" .. self.status_dict.removed .. " " end
			if self.status_dict.changed ~= 0 then s = s .. "~" .. self.status_dict.changed .. " " end
			return #s > 0 and (s .. " ") or ""
		end,
	},
}

-- Right-aligned Ruler
local Ruler = {
	provider = " %l/%L:%c %P ",
	hl = { fg = "#ffffff", bg = colors.normal, bold = true }
}

-- Put it together
heirline.setup({
	statusline = {
		ViMode,
		FileDir,
		FileType,
		FileName,
		{ provider = "%= "},
		Git,
		GitAheadBehind,
		{ provider = "  "},
		Ruler,
	},
	winbar = nil,
	--Tabline =
})

lush(theme)

vim.api.nvim_set_hl(0, "StatusLine",   { fg = palette.fg, bg = palette.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "VertSplit",    { fg = palette.black, bg = palette.bg })
