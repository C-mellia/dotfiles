require("nvim-tree").setup({
    disable_netrw = true,
	sort = {
		sorter = "case_sensitive",
	},
	filters = {
		dotfiles = true,
	},
    view = {
        width = 30,
    },
    renderer = {
        add_trailing = true,
        indent_markers = {
            enable = true
        },
        icons = {
            show = {
                file = false,
                folder = false,
                folder_arrow = false,
                git = false,
                modified = false,
                diagnostics = false,
                bookmarks = true,
            },
        },
    },
    actions = {
        change_dir = {
            enable = false,
        },
    },
})
