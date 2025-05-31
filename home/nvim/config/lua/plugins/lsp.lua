return {
    "neovim/nvim-lspconfig",
config = function()
local lspconfig = require("lspconfig")
--lsps goes here
lspconfig.nil_ls.setup{}
lspconfig.clangd.setup{}
--lspconfig.lua_ls.setup{}
end,
}
