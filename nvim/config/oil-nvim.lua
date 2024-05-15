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
        ["<C-l>"] = "actions.select_vsplit",
    },
    use_default_keymaps = true,
    show_hidden = true,
})
