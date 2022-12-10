local helpers = require("helpers")
local M = {}

M.run_game = function()
    helpers.show_board()
end

-- TODO: remove call to run_game. Just here for quick iteration while building
M.run_game()
return M
