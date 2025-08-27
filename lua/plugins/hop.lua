return {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but recommended
    config = function()
        require("hop").setup({
            keys = "etovxqpdygfblzhckisuran",
            jump_on_sole_occurrence = true,
            case_insensitive = true,
            create_hl_autocmd = true,
        })

        -- AceJump-like keybindings
        vim.keymap.set('n', '<leader>j', '<cmd>HopChar1<cr>', { desc = "Hop to character" })
        vim.keymap.set('n', '<leader>jj', '<cmd>HopChar2<cr>', { desc = "Hop to 2 characters" }) 
        vim.keymap.set('n', '<leader>jw', '<cmd>HopWord<cr>', { desc = "Hop to word" })
        vim.keymap.set('n', '<leader>jl', '<cmd>HopLine<cr>', { desc = "Hop to line" })
        vim.keymap.set('n', '<leader>jp', '<cmd>HopPattern<cr>', { desc = "Hop to pattern" })
        
        -- Visual mode support
        vim.keymap.set('v', '<leader>j', '<cmd>HopChar1<cr>', { desc = "Hop to character" })
        vim.keymap.set('v', '<leader>jw', '<cmd>HopWord<cr>', { desc = "Hop to word" })
        vim.keymap.set('v', '<leader>jl', '<cmd>HopLine<cr>', { desc = "Hop to line" })

        -- Alternative single-key shortcuts (more like AceJump)
        vim.keymap.set('n', 's', '<cmd>HopChar2<cr>', { desc = "Hop search 2 chars" })
        vim.keymap.set('n', 'S', '<cmd>HopWord<cr>', { desc = "Hop to word" })
        
        -- Hop in current line only
        vim.keymap.set('n', 'f', function()
            require('hop').hint_char1({ 
                direction = require('hop.hint').HintDirection.AFTER_CURSOR, 
                current_line_only = true 
            })
        end, { desc = "Hop forward in line" })
        
        vim.keymap.set('n', 'F', function()
            require('hop').hint_char1({ 
                direction = require('hop.hint').HintDirection.BEFORE_CURSOR, 
                current_line_only = true 
            })
        end, { desc = "Hop backward in line" })
        
        vim.keymap.set('n', 't', function()
            require('hop').hint_char1({ 
                direction = require('hop.hint').HintDirection.AFTER_CURSOR, 
                current_line_only = true, 
                hint_offset = -1 
            })
        end, { desc = "Hop till character forward" })
        
        vim.keymap.set('n', 'T', function()
            require('hop').hint_char1({ 
                direction = require('hop.hint').HintDirection.BEFORE_CURSOR, 
                current_line_only = true, 
                hint_offset = 1 
            })
        end, { desc = "Hop till character backward" })
    end,
}