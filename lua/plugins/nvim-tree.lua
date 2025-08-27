return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
        -- disable netrw at the very start of your init.lua (strongly advised)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- set termguicolors to enable highlight groups
        vim.opt.termguicolors = true

        require("nvim-tree").setup({
            view = {
                width = 30,
                side = "left",
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
            git = {
                enable = true,
            },
            actions = {
                open_file = {
                    quit_on_open = false,
                },
            },
            update_focused_file = {
                enable = false,
            },
        })
    end,
}