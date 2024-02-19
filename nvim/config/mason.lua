local global_conf = require("global_conf")
require("mason").setup({
})
require("mason-lspconfig").setup({
    ensure_installed = global_conf.mason_ensure_installed,
    automatic_installation = true,
})
