local game_window = require("game_window")
local M = {}

M.run = function()
    game_window.show()
end

-- TODO: remove call to run. Just here for quick iteration while building
M.run()
return M
