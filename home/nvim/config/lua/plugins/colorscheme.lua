return {
{"nyoom-engineering/oxocarbon.nvim", priority = 1000 },
{"ellisonleao/gruvbox.nvim", priority = 1000},
{"EdenEast/nightfox.nvim", priority = 1000},
{"AlexvZyl/nordic.nvim", priority = 1000},
{"rebelot/kanagawa.nvim", priority = 1000},
{"olimorris/onedarkpro.nvim", priority = 1000,
config = function()
vim.cmd.colorscheme "oxocarbon"
--vim.cmd.colorscheme "gruvbox"
--vim.cmd.colorscheme "carbonfox"
--vim.cmd.colorscheme "nordic"
--vim.cmd.colorscheme "kanagawa-dragon"
--vim.cmd.colorscheme "onedark_dark"
end
 },
}
