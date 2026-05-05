--[[
    Dusk - A rich text formatting library

    Author:   Praise Jacob <iampraisejacob@gmail.com>
    Repo:     https://github.com/felix-kyun/dusk

    SPDX-License-Identifier: MIT
    Copyright (c) 2026 Praise Jacob
]]

--- @class Dusk
--- @overload fun(...: string) string
--- @field reset 			Dusk
--- @field bold 			Dusk
--- @field dim 				Dusk
--- @field italic 			Dusk
--- @field underline 		Dusk
--- @field blink 			Dusk
--- @field inverse 			Dusk
--- @field hidden 			Dusk
--- @field strikethrough 	Dusk
--- @field black 			Dusk
--- @field red 				Dusk
--- @field green 			Dusk
--- @field yellow 			Dusk
--- @field blue 			Dusk
--- @field magenta 			Dusk
--- @field cyan 			Dusk
--- @field white 			Dusk
--- @field gray 			Dusk
--- @field grey 			Dusk
--- @field blackBright 		Dusk
--- @field redBright 		Dusk
--- @field greenBright 		Dusk
--- @field yellowBright 	Dusk
--- @field blueBright 		Dusk
--- @field magentaBright 	Dusk
--- @field cyanBright 		Dusk
--- @field whiteBright 		Dusk
--- @field bgBlack 			Dusk
--- @field bgRed 			Dusk
--- @field bgGreen 			Dusk
--- @field bgYellow 		Dusk
--- @field bgBlue 			Dusk
--- @field bgMagenta 		Dusk
--- @field bgCyan 			Dusk
--- @field bgWhite 			Dusk
--- @field bgGray 			Dusk
--- @field bgGrey 			Dusk
--- @field bgBlackBright 	Dusk
--- @field bgRedBright 		Dusk
--- @field bgGreenBright 	Dusk
--- @field bgYellowBright 	Dusk
--- @field bgBlueBright 	Dusk
--- @field bgMagentaBright 	Dusk
--- @field bgCyanBright 	Dusk
--- @field bgWhiteBright 	Dusk

local codes = {
	-- Modifiers
	reset           = { enable = "\27[0m", disable = "\27[0m" },
	bold            = { enable = "\27[1m", disable = "\27[22m" },
	dim             = { enable = "\27[2m", disable = "\27[22m" },
	italic          = { enable = "\27[3m", disable = "\27[23m" },
	underline       = { enable = "\27[4m", disable = "\27[24m" },
	blink           = { enable = "\27[5m", disable = "\27[25m" },
	inverse         = { enable = "\27[7m", disable = "\27[27m" },
	hidden          = { enable = "\27[8m", disable = "\27[28m" },
	strikethrough   = { enable = "\27[9m", disable = "\27[29m" },

	-- Foreground colors
	black           = { enable = "\27[30m", disable = "\27[39m" },
	red             = { enable = "\27[31m", disable = "\27[39m" },
	green           = { enable = "\27[32m", disable = "\27[39m" },
	yellow          = { enable = "\27[33m", disable = "\27[39m" },
	blue            = { enable = "\27[34m", disable = "\27[39m" },
	magenta         = { enable = "\27[35m", disable = "\27[39m" },
	cyan            = { enable = "\27[36m", disable = "\27[39m" },
	white           = { enable = "\27[37m", disable = "\27[39m" },
	gray            = { enable = "\27[90m", disable = "\27[39m" },
	grey            = { enable = "\27[90m", disable = "\27[39m" },

	-- Bright foreground colors
	blackBright     = { enable = "\27[90m", disable = "\27[39m" },
	redBright       = { enable = "\27[91m", disable = "\27[39m" },
	greenBright     = { enable = "\27[92m", disable = "\27[39m" },
	yellowBright    = { enable = "\27[93m", disable = "\27[39m" },
	blueBright      = { enable = "\27[94m", disable = "\27[39m" },
	magentaBright   = { enable = "\27[95m", disable = "\27[39m" },
	cyanBright      = { enable = "\27[96m", disable = "\27[39m" },
	whiteBright     = { enable = "\27[97m", disable = "\27[39m" },

	-- Background colors
	bgBlack         = { enable = "\27[40m", disable = "\27[49m" },
	bgRed           = { enable = "\27[41m", disable = "\27[49m" },
	bgGreen         = { enable = "\27[42m", disable = "\27[49m" },
	bgYellow        = { enable = "\27[43m", disable = "\27[49m" },
	bgBlue          = { enable = "\27[44m", disable = "\27[49m" },
	bgMagenta       = { enable = "\27[45m", disable = "\27[49m" },
	bgCyan          = { enable = "\27[46m", disable = "\27[49m" },
	bgWhite         = { enable = "\27[47m", disable = "\27[49m" },
	bgGray          = { enable = "\27[100m", disable = "\27[49m" },
	bgGrey          = { enable = "\27[100m", disable = "\27[49m" },

	-- Bright background colors
	bgBlackBright   = { enable = "\27[100m", disable = "\27[49m" },
	bgRedBright     = { enable = "\27[101m", disable = "\27[49m" },
	bgGreenBright   = { enable = "\27[102m", disable = "\27[49m" },
	bgYellowBright  = { enable = "\27[103m", disable = "\27[49m" },
	bgBlueBright    = { enable = "\27[104m", disable = "\27[49m" },
	bgMagentaBright = { enable = "\27[105m", disable = "\27[49m" },
	bgCyanBright    = { enable = "\27[106m", disable = "\27[49m" },
	bgWhiteBright   = { enable = "\27[107m", disable = "\27[49m" },
}

--- Creates a shallow copy of a table.
--- @param t table
--- @return table
local function copy(t)
	local result = {}
	for k, v in pairs(t) do
		result[k] = v
	end
	return result
end

return setmetatable({}, {
	--- returns a new collector with the style appended.
	--- @param collector Dusk
	--- @param key string
	--- @return Dusk
	__index = function(collector, key)
		if (type(key) == "number") then
			return rawget(collector, key)
		end

		if not codes[key] then
			error("Dusk: unknown style '" .. key .. "'")
			return collector
		end

		local newCollector = copy(collector)
		newCollector[#newCollector + 1] = codes[key]

		return setmetatable(newCollector, getmetatable(collector))
	end,
	--- returns the styled string.
	--- @param collector Dusk
	--- @param ... string
	--- @return string
	__call = function(collector, ...)
		local open, close = "", ""
		local target = table.concat(table.pack(...), " ")

		for _, code in ipairs(collector) do
			open = open .. code.enable
			close = code.disable .. close
		end

		return open .. target .. close
	end,
	_codes = codes
}) --[[ @as Dusk ]]
