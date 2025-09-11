-- We'll set the double ESC keybinding per terminal buffer instead of globally

local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function open_floating_terminal(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true)
    end
    if not buf then
        error("Failed to create buffer")
    end

    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
    })

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = open_floating_terminal({ buf = state.floating.buf });
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
        vim.cmd("startinsert!")
        
        -- Set buffer-local keybinding for double ESC every time terminal opens
        vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n><cmd>FltermClose<CR>", { 
            buffer = state.floating.buf, 
            noremap = true, 
            silent = true 
        })
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

local close_terminal = function()
    if vim.api.nvim_win_is_valid(state.floating.win) then
        vim.api.nvim_win_hide(state.floating.win)
    end
end

vim.api.nvim_create_user_command("Flterm", toggle_terminal, {})
vim.api.nvim_create_user_command("FltermClose", close_terminal, {})

-- Keybindings for floating terminal
vim.api.nvim_set_keymap('n', '<leader>ft', [[:Flterm<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fc', [[:FltermClose<CR>]], { noremap = true, silent = true, desc = "Close floating terminal" })

-- Close terminal from terminal mode with Ctrl+Q
vim.api.nvim_set_keymap('t', '<C-q>', '<cmd>FltermClose<CR>', { noremap = true, silent = true })
