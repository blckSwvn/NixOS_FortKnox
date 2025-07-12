return {
    "neovim/nvim-lspconfig",
config = function()
local lspconfig = require("lspconfig")
--lsps goes here
lspconfig.nixd.setup{}
lspconfig.clangd.setup{}
--lspconfig.lua_ls.setup{}
end,
}
