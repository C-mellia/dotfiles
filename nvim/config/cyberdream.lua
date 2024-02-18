local global_conf = require("global_conf")
require("cyberdream").setup({
    -- Recommended - see "Configuring" below for more config options
    transparent = global_conf.transparent_bg,
    italic_comments = true,
    hide_fillchars = true,
    borderless_telescope = true,
})
