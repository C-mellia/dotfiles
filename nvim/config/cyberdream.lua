local global_conf = require("global_conf")
require("cyberdream").setup({
	transparent = global_conf.transparent_bg,
	italic_comments = true,
	hide_fillchars = true,
	borderless_telescope = true,
})
