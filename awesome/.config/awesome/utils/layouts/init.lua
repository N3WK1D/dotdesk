--[[
     Bling
     Layouts, widgets and utilities for Awesome WM
     Last Updated: 5 March, 2022
--]]

local M = {}

local layouts = {
    "centered"
}

for _, layout_name in ipairs(layouts) do
    M[layout_name] = require(... .. "." .. layout_name)
end

return M