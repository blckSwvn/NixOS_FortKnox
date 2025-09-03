-- =======================
-- Neovim Init.lua
-- =======================

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

-- =======================
-- PACKS
-- =======================
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
  {src = "https://github.com/vimplug/nvim-colorizer.lua"},
  {src = "https://github.com/rktjmp/lush.nvim"},
})

-- =======================
-- PLUGIN CONFIGS
-- =======================
require("colorizer").setup()

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

-- =======================
-- LSP CONFIG
-- =======================
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

-- =======================
-- CMP CONFIG
-- =======================
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

-- =======================
-- LUSH THEME
-- =======================
local lush = require("lush")

local palette = {
  bg        = "#000000",
  fg        = "#DADADA",
  black     = "#404040",
  red       = "#DB1200",
  green     = "#3FC8B3",
  yellow    = "#F5BC00",
  blue      = "#4472Ca",
  magenta   = "#16AC5A",
  cyan      = "#92bef4",
  white     = "#E0E0E0",
  bright_black   = "#5C5C5C",
  bright_red     = "#FF0A2F",
  bright_green   = "#26E37B",
  bright_yellow  = "#FFCB1F",
  bright_blue    = "#7094D7",
  bright_magenta = "#581EC2",
  bright_cyan    = "#B5D3F8",
  bright_white   = "#ffffff",
}

local theme = lush(function()
  return {
    Normal      { fg = palette.fg, bg = palette.bg },
    Cursor      { fg = palette.bg, bg = palette.fg },
    Visual      { bg = palette.black },
    Comment     { fg = palette.bright_black, gui = "italic" },
    Constant    { fg = palette.cyan },
    String      { fg = palette.green },
    Number      { fg = palette.yellow },
    Boolean     { fg = palette.red },
    Identifier  { fg = palette.blue },
    Function    { fg = palette.magenta },
    Statement   { fg = palette.red, gui = "bold" },
    Conditional { fg = palette.red },
    Keyword     { fg = palette.cyan },
    Operator    { fg = palette.fg },
    Type        { fg = palette.yellow },
    PreProc     { fg = palette.cyan },
    Special     { fg = palette.blue },
    Error       { fg = palette.bright_red, gui = "bold" },
    WarningMsg  { fg = palette.bright_yellow, gui = "bold" },
    Info        { fg = palette.bright_blue },
    Todo        { fg = palette.bright_magenta, gui = "bold,italic" },
  }
end)

-- =======================
-- HEIRLINE STATUSBAR
-- =======================
local heirline = require("heirline")
local devicons = require("nvim-web-devicons")

local colors = {
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
    cols  = { n="normal", i="string", v="type", V="type", ["\22"]="type", R="error", c="warn", t="string" },
  },
  provider = function(self) return " " .. self.names[self.mode] .. " " end,
  hl = function(self) return { fg="#ffffff", bg=colors[self.cols[self.mode]], bold=true } end,
}

-- File info
local FileDir = {
  provider = function()
    local filepath = vim.api.nvim_buf_get_name(0)
    return " " .. vim.fn.fnamemodify(filepath, ":.:h") .. "/"
  end,
}
local FileName = { provider = " %t ", hl = { fg = colors.type, bg = colors.normal } }

local FileType = {
  init = function(self)
    self.ft = vim.bo.filetype
    self.icon, self.icon_color = devicons.get_icon_color_by_filetype(self.ft, { default = true })
  end,
  provider = function(self) return " " .. self.icon .. " " end,
  hl = function(self) return { fg = self.icon_color, bg = colors.normal } end,
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
    provider = function(self) return " " .. self.status_dict.head .. " " end,
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
    { provider = "  "},
    Ruler,
  },
  winbar = nil,
})

lush(theme)

vim.api.nvim_set_hl(0, "StatusLine",   { fg = palette.fg, bg = palette.bg, bold = true })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = palette.fg, bg = palette.bg })
vim.api.nvim_set_hl(0, "VertSplit",    { fg = palette.black, bg = palette.bg })
