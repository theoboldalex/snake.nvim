local G = {}
math.randomseed(os.time())
math.random(); math.random(); math.random();

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

local map_window_close_keys = function (buffer)
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

local fill_buffer = function (x, y)
    local filler = {}
    local blank_space = " "
    local food = "*"
    local blank_line = string.rep(blank_space, width)
    local food_line =
        string.rep(blank_space, width - x - 1) ..
        food ..
        string.rep(blank_space, x)

    for i = 1, height do
        if (i == y) then
            table.insert(filler, food_line)
        else
            table.insert(filler, blank_line)
        end
    end

    return filler
end

local render_food = function (x, y)
    return fill_buffer(x, y)
end

G.show = function()
    local buffer = vim.api.nvim_create_buf(false, true)
    map_window_close_keys(buffer)
    local buffer_content = render_food(math.random(width), math.random(height))

    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, buffer_content)
    vim.api.nvim_open_win(buffer, true, opts)
    -- lets figure out how to move the cursor on a timer. Busy loop? urgh...
    -- might need to redraw buffer instead
    for _ = 1, 10 do
        vim.cmd("normal! l")
    end
end

return G
