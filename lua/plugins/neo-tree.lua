return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim"
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function()
            vim.keymap.set('n', '<C-n>', ':Neotree filesystem reveal left<CR>', { desc= 'Open Neotree to the left' })
            vim.keymap.set('n', '<leader>nc', ':Neotree close<CR>', { desc= 'Open Neotree to the left' })
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        hide_by_name = { "node_modules", ".DS_Store" }, -- Exclude large/unnecessary directories
                    },
                    follow_current_file = {
                        enable = true,
                    }, -- Focus tree view on the active file
                    group_empty_dirs = true, -- Group empty folders for clarity
                    hijack_netrw_behavior = "open_current", -- Avoid conflicts with netrw
                },
                git_status = {
                    enable = true, -- Enable Git integration (set to false for faster loading)
                    window = {
                        position = "float", -- Display Git status in a floating window
                    },
                },
            })
        end,
        event = "BufWinEnter",
    }
}
