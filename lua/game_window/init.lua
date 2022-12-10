local G = {}

math.randomseed(os.time())
math.random(); math.random(); math.random();

local width = 75
local height = 25
WINDOW_WIDTH = (vim.api.nvim_win_get_width(0) / 2) - (width / 2)
WINDOW_HEIGHT = (vim.api.nvim_win_get_height(0) / 2) - (height / 2)
local opts = {
    style = "minimal",
    width = width,
    height = height,
    relative = "win",
    row = WINDOW_HEIGHT,
    col = WINDOW_WIDTH,
}

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

local fill_buffer = function(food_vector)
    local line = string.rep(" ", width)
    local food_line = ""
    if (food_vector) then
        food_line = string.rep(" ", 10)
        food_line = food_line .. "*"
    end
    local filler = {}

    for i = 1, height do
        if (i == food_vector.y) then
            table.insert(filler, food_line)
        else
            table.insert(filler, line)
        end
    end
    return filler
end

local render_food = function (food_position)
    return fill_buffer(food_position)
end

G.show = function()
    print(WINDOW_WIDTH)
    local buffer = vim.api.nvim_create_buf(false, true)
    local food_vector = {
        x = math.random(WINDOW_WIDTH),
        y = math.random(WINDOW_HEIGHT),
    }
    local buffer_content = render_food(food_vector)
    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, buffer_content)
    map_window_close_keys(buffer)

    vim.api.nvim_open_win(buffer, true, opts)
end

return G
