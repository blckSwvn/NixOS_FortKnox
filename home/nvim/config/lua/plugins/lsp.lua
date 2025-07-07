return {
    "neovim/nvim-lspconfig",
config = function()
local lspconfig = require("lspconfig")
--lsps goes here
lspconfig.nix.setup{}
lspconfig.clangd.setup{}
--lspconfig.lua_ls.setup{}
end,
}
