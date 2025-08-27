return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,                       -- move to prev result
                        ["<C-j>"] = actions.move_selection_next,                           -- move to next result
                        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
                    }
                },
                -- Disable treesitter in preview to avoid parser errors
                preview = {
                    treesitter = false, -- Disable treesitter highlighting to prevent parser errors
                    timeout = 250, -- Timeout for preview in ms
                },
            }
        })

        local builtin = require('telescope.builtin')
        
        -- File finding
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find git files' })
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find recent files' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find help' })
        vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Find quickfix' })

        -- Text searching with input prompt
        vim.keymap.set('n', '<leader>fr', function()
            builtin.grep_string({ search = vim.fn.input("Search > ") })
        end, { desc = "Search with prompt" })

        -- Find instance instance of current view being included
        vim.keymap.set('n', '<leader>fc', function()
            local filename_without_extension = vim.fn.expand('%:t:r')
            builtin.grep_string({ search = filename_without_extension })
        end, { desc = "Find current file: " })

        -- Grep current string (for when gd doesn't work)
        vim.keymap.set('n', '<leader>fs', function()
            builtin.grep_string({})
        end, { desc = "Find current string: " })

        -- Live search (search as you type) - requires ripgrep
        vim.keymap.set('n', '<leader>fw', function()
            local ok, _ = pcall(builtin.live_grep)
            if not ok then
                print("Ripgrep not found. Use <leader>fr for search with prompt instead.")
                builtin.grep_string({ search = vim.fn.input("Fallback Search > ") })
            end
        end, { desc = "Live search" })

        -- Alternative search methods that work without ripgrep
        vim.keymap.set('n', '<leader>ft', function()
            builtin.grep_string({ 
                search = vim.fn.input("Text Search > "),
                use_regex = false 
            })
        end, { desc = "Text search (no ripgrep needed)" })

        -- Search in current buffer
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find()
        end, { desc = "Search in current file" })

        -- Language-specific searches
        vim.keymap.set('n', '<leader>fpy', function()
            builtin.live_grep({ glob_pattern = "*.py" })
        end, { desc = "Search in Python files" })

        -- Find files in vim config (Windows compatible)
        vim.keymap.set('n', '<leader>fi', function()
            builtin.find_files({ cwd = vim.fn.stdpath("config") })
        end, { desc = "Find in vim config" })
    end
}
