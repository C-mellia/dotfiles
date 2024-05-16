require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
        "permissions",
        "size",
        -- "mtime",
    },
    delete_to_trash = false,
    keymaps = {
        ["g?"] = "actions.show_help",
        ["-"] = "actions.parent",
        ["<C-l>"] = "actions.select",
		["<C-y>"] = "actions.select_split",
		["r"] = "actions.refresh",
    },
    use_default_keymaps = true,
    show_hidden = true,
})
