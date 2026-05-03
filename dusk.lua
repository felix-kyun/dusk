--[[
    Dusk - A rich text formatting library

    Author:   Praise Jacob <iampraisejacob@gmail.com>
    Repo:     https://github.com/felix-kyun/dusk

    SPDX-License-Identifier: MIT
    Copyright (c) 2026 Praise Jacob
]]

--- @class Dusk
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
local Dusk = {}
local codes = {
	-- Modifiers
	reset           = { open = "\27[0m", close = "\27[0m" },
	bold            = { open = "\27[1m", close = "\27[22m" },
	dim             = { open = "\27[2m", close = "\27[22m" },
	italic          = { open = "\27[3m", close = "\27[23m" },
	underline       = { open = "\27[4m", close = "\27[24m" },
	blink           = { open = "\27[5m", close = "\27[25m" },
	inverse         = { open = "\27[7m", close = "\27[27m" },
	hidden          = { open = "\27[8m", close = "\27[28m" },
	strikethrough   = { open = "\27[9m", close = "\27[29m" },

	-- Foreground colors
	black           = { open = "\27[30m", close = "\27[39m" },
	red             = { open = "\27[31m", close = "\27[39m" },
	green           = { open = "\27[32m", close = "\27[39m" },
	yellow          = { open = "\27[33m", close = "\27[39m" },
	blue            = { open = "\27[34m", close = "\27[39m" },
	magenta         = { open = "\27[35m", close = "\27[39m" },
	cyan            = { open = "\27[36m", close = "\27[39m" },
	white           = { open = "\27[37m", close = "\27[39m" },
	gray            = { open = "\27[90m", close = "\27[39m" },
	grey            = { open = "\27[90m", close = "\27[39m" },

	-- Bright foreground colors
	blackBright     = { open = "\27[90m", close = "\27[39m" },
	redBright       = { open = "\27[91m", close = "\27[39m" },
	greenBright     = { open = "\27[92m", close = "\27[39m" },
	yellowBright    = { open = "\27[93m", close = "\27[39m" },
	blueBright      = { open = "\27[94m", close = "\27[39m" },
	magentaBright   = { open = "\27[95m", close = "\27[39m" },
	cyanBright      = { open = "\27[96m", close = "\27[39m" },
	whiteBright     = { open = "\27[97m", close = "\27[39m" },

	-- Background colors
	bgBlack         = { open = "\27[40m", close = "\27[49m" },
	bgRed           = { open = "\27[41m", close = "\27[49m" },
	bgGreen         = { open = "\27[42m", close = "\27[49m" },
	bgYellow        = { open = "\27[43m", close = "\27[49m" },
	bgBlue          = { open = "\27[44m", close = "\27[49m" },
	bgMagenta       = { open = "\27[45m", close = "\27[49m" },
	bgCyan          = { open = "\27[46m", close = "\27[49m" },
	bgWhite         = { open = "\27[47m", close = "\27[49m" },
	bgGray          = { open = "\27[100m", close = "\27[49m" },
	bgGrey          = { open = "\27[100m", close = "\27[49m" },

	-- Bright background colors
	bgBlackBright   = { open = "\27[100m", close = "\27[49m" },
	bgRedBright     = { open = "\27[101m", close = "\27[49m" },
	bgGreenBright   = { open = "\27[102m", close = "\27[49m" },
	bgYellowBright  = { open = "\27[103m", close = "\27[49m" },
	bgBlueBright    = { open = "\27[104m", close = "\27[49m" },
	bgMagentaBright = { open = "\27[105m", close = "\27[49m" },
	bgCyanBright    = { open = "\27[106m", close = "\27[49m" },
	bgWhiteBright   = { open = "\27[107m", close = "\27[49m" },
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

return setmetatable(Dusk, {
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
	--- @param str string
	--- @return string
	__call = function(collector, str)
		local open, close = "", ""

		for _, code in ipairs(collector) do
			open = open .. code.open
			close = code.close .. close
		end

		return open .. str .. close
	end,
	_codes = codes
})
