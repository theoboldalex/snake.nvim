local M = {}

local width = 75
local height = 25
local window_width = (vim.api.nvim_win_get_width(0) / 2) - (width / 2)
local window_height = (vim.api.nvim_win_get_height(0) / 2) - (height / 2)
local opts = {
    style = "minimal",
    width = width,
    height = height,
    relative = "win",
    row = window_height,
    col = window_width,
}

local fill_buffer = function()
    local line = string.rep(" ", width)
    local filler = {}

    for _ = 1, height do
        table.insert(filler, line)
    end
    return filler
end

local map_window_close_keys = function(buffer)
    vim.api.nvim_buf_set_keymap(
        buffer,
        "n",
        "<Esc>",
        ":close<CR>",
        {
            silent=true,
            nowait=true,
            noremap=true
        }
    )
end

M.show_board = function()
    local buffer = vim.api.nvim_create_buf(false, true)
    local buffer_content = fill_buffer()
    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, buffer_content)
    map_window_close_keys(buffer)

    vim.api.nvim_open_win(buffer, true, opts)
end

M.run_game = function()
    M.show_board()
end

-- TODO: remove call to run_game
M.run_game()
return M
