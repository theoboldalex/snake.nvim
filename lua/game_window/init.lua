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
        food_line = string.rep(" ", width - food_vector.x - 1)
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
    local buffer = vim.api.nvim_create_buf(false, true)
    local food_vector = {
        x = math.random(window_width),
        y = math.random(window_height),
    }
    print(window_width)
    local buffer_content = render_food(food_vector)
    vim.api.nvim_buf_set_lines(buffer, 0, -1, false, buffer_content)
    map_window_close_keys(buffer)

    vim.api.nvim_open_win(buffer, true, opts)
end

return G
