-- KEYBINDS 
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Alt Up/Down in vscode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z") -- Remap joining lines
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Keep cursor in place while moving up/down page
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv") -- center screen when looping search results
vim.keymap.set("n", "N", "Nzzzv")

-- paste and don't replace clipboard over deleted text
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])


-- sometimes in insert mode, control-c doesn't exactly work like escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- jk to escape insert mode (faster than reaching for Esc key)
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>") -- alternative in case you type in different order

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- What the heck is Ex mode?
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- getting Alex off my back :)
vim.keymap.set("n", "<leader>dg", "<cmd>DogeGenerate<cr>")

-- lint / format php files for LC
vim.keymap.set("n", "<leader>cc", "<cmd>!php-cs-fixer fix % --using-cache=no<cr>")

-- Replace all instances of whatever is under cursor (on line)
vim.keymap.set("n", "<leader>s", [[:s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-- make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- yank into clipboard even if on ssh
vim.keymap.set('n', '<leader>y', '<Plug>OSCYankOperator')
vim.keymap.set('v', '<leader>y', '<Plug>OSCYankVisual')

-- reload without exiting vim
vim.keymap.set("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<cr>")

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- nvim-tree toggle
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })

-- Navigate back and forward through cursor positions (jump list)
vim.keymap.set("n", "<C-Left>", "<C-o>", { desc = "Go back to previous cursor position" })
vim.keymap.set("n", "<C-Right>", "<C-i>", { desc = "Go forward to next cursor position" })

-- Alternative keybindings for back/forward navigation
vim.keymap.set("n", "gb", "<C-o>", { desc = "Go back" })
vim.keymap.set("n", "gf", "<C-i>", { desc = "Go forward" })

-- Mouse back/forward support (if available)
vim.keymap.set("n", "<X1Mouse>", "<C-o>", { desc = "Mouse back" })
vim.keymap.set("n", "<X2Mouse>", "<C-i>", { desc = "Mouse forward" })

-- Close quickfix/location list (reference results, diagnostics, etc.)
vim.keymap.set("n", "<leader>q", "<cmd>cclose<cr>", { desc = "Close quickfix list" })
vim.keymap.set("n", "<leader>l", "<cmd>lclose<cr>", { desc = "Close location list" })

-- Toggle quickfix/location list
vim.keymap.set("n", "<leader>tq", function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "Toggle quickfix list" })

-- Navigate through quickfix results
vim.keymap.set("n", "<leader>cn", "<cmd>cnext<cr>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<leader>cp", "<cmd>cprev<cr>", { desc = "Previous quickfix item" })

-- source file (only for Lua files)
vim.keymap.set("n", "<leader><leader>", function()
    local filetype = vim.bo.filetype
    if filetype == "lua" then
        vim.cmd("so")
    else
        vim.notify("Can only source Lua files", vim.log.levels.WARN)
    end
end)

-- Insert mode: Enter insert mode on new line below cursor
vim.keymap.set("n", "<leader>o", "o", { desc = "Open line below and insert" })

-- Select all text in buffer (like Ctrl+A in other editors)
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all text" })

-- Increment/Decrement numbers (since <C-a> is remapped)
vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
-- Alternative keybinds
vim.keymap.set("n", "<leader>ia", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "<leader>id", "<C-x>", { desc = "Decrement number" })