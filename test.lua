local d = require("dusk")
local codes = getmetatable(d)._internals.codes
local registry = getmetatable(d)._internals.registry

-- multi chaining
assert(d.red.bold("test") == ""
	.. codes.red.enable
	.. codes.bold.enable
	.. "test"
	.. codes.bold.disable
	.. codes.red.disable,
	"multi chaining")

-- chain reuse
local redBold = d.red.bold
assert(redBold.strikethrough("test") == ""
	.. codes.red.enable
	.. codes.bold.enable
	.. codes.strikethrough.enable
	.. "test"
	.. codes.strikethrough.disable
	.. codes.bold.disable
	.. codes.red.disable,
	"chain reuse strikethrough")
assert(redBold.underline("test") == ""
	.. codes.red.enable
	.. codes.bold.enable
	.. codes.underline.enable
	.. "test"
	.. codes.underline.disable
	.. codes.bold.disable
	.. codes.red.disable,
	"chain reuse")

-- multiple args
assert(d.red.bold("test", "test2") == ""
	.. codes.red.enable
	.. codes.bold.enable
	.. "test test2"
	.. codes.bold.disable
	.. codes.red.disable,
	"multiple args")

-- rgb
local rgb = registry[codes.rgb(d)(255, 0, 0)]
assert(rgb.enable == ("\27[38;2;%d;%d;%dm"):format(255, 0, 0))
assert(rgb.disable == "\27[39m")
assert(d.rgb(255, 0, 0)("test") == ""
	.. rgb.enable
	.. "test"
	.. rgb.disable,
	"rgb")

local bgRgb = registry[codes.bgRgb(d)(255, 0, 0)]
assert(bgRgb.enable == ("\27[48;2;%d;%d;%dm"):format(255, 0, 0))
assert(bgRgb.disable == "\27[49m")
assert(d.bgRgb(255, 0, 0)("test") == ""
	.. bgRgb.enable
	.. "test"
	.. bgRgb.disable,
	"bgRgb")

-- hex
local hex = registry[codes.hex(d)("#ff0000")]
assert(hex.enable == ("\27[38;2;%d;%d;%dm"):format(255, 0, 0))
assert(hex.disable == "\27[39m")
assert(d.hex("#ff0000")("test") == ""
	.. hex.enable
	.. "test"
	.. hex.disable,
	"hex")

local bgHex = registry[codes.bgHex(d)("#ff0000")]
assert(bgHex.enable == ("\27[48;2;%d;%d;%dm"):format(255, 0, 0))
assert(bgHex.disable == "\27[49m")
assert(d.bgHex("#ff0000")("test") == ""
	.. bgHex.enable
	.. "test"
	.. bgHex.disable,
	"bgHex")

-- error checking
local ok, err

-- error on invalid rgb value
ok, err = pcall(d.rgb, 256, 0, 0)
assert(not ok, err)

-- error on invalid hex value
for _, code in ipairs({ "#fg0000", "#000", "#000000g" }) do
	ok, err = pcall(d.hex, code)
	assert(not ok, err)
end

--- code map check
local codemap = {
	--- mods
	reset           = { enable = "\x1b[0m", disable = "\x1b[0m" },
	bold            = { enable = "\x1b[1m", disable = "\x1b[22m" },
	dim             = { enable = "\x1b[2m", disable = "\x1b[22m" },
	italic          = { enable = "\x1b[3m", disable = "\x1b[23m" },
	underline       = { enable = "\x1b[4m", disable = "\x1b[24m" },
	blink           = { enable = "\x1b[5m", disable = "\x1b[25m" },
	inverse         = { enable = "\x1b[7m", disable = "\x1b[27m" },
	hidden          = { enable = "\x1b[8m", disable = "\x1b[28m" },
	strikethrough   = { enable = "\x1b[9m", disable = "\x1b[29m" },

	--- fg
	black           = { enable = "\x1b[30m", disable = "\x1b[39m" },
	red             = { enable = "\x1b[31m", disable = "\x1b[39m" },
	green           = { enable = "\x1b[32m", disable = "\x1b[39m" },
	yellow          = { enable = "\x1b[33m", disable = "\x1b[39m" },
	blue            = { enable = "\x1b[34m", disable = "\x1b[39m" },
	magenta         = { enable = "\x1b[35m", disable = "\x1b[39m" },
	cyan            = { enable = "\x1b[36m", disable = "\x1b[39m" },
	white           = { enable = "\x1b[37m", disable = "\x1b[39m" },
	gray            = { enable = "\x1b[90m", disable = "\x1b[39m" },
	grey            = { enable = "\x1b[90m", disable = "\x1b[39m" },

	--- bright fg
	blackBright     = { enable = "\x1b[90m", disable = "\x1b[39m" },
	redBright       = { enable = "\x1b[91m", disable = "\x1b[39m" },
	greenBright     = { enable = "\x1b[92m", disable = "\x1b[39m" },
	yellowBright    = { enable = "\x1b[93m", disable = "\x1b[39m" },
	blueBright      = { enable = "\x1b[94m", disable = "\x1b[39m" },
	magentaBright   = { enable = "\x1b[95m", disable = "\x1b[39m" },
	cyanBright      = { enable = "\x1b[96m", disable = "\x1b[39m" },
	whiteBright     = { enable = "\x1b[97m", disable = "\x1b[39m" },

	--- bg
	bgBlack         = { enable = "\x1b[40m", disable = "\x1b[49m" },
	bgRed           = { enable = "\x1b[41m", disable = "\x1b[49m" },
	bgGreen         = { enable = "\x1b[42m", disable = "\x1b[49m" },
	bgYellow        = { enable = "\x1b[43m", disable = "\x1b[49m" },
	bgBlue          = { enable = "\x1b[44m", disable = "\x1b[49m" },
	bgMagenta       = { enable = "\x1b[45m", disable = "\x1b[49m" },
	bgCyan          = { enable = "\x1b[46m", disable = "\x1b[49m" },
	bgWhite         = { enable = "\x1b[47m", disable = "\x1b[49m" },
	bgGray          = { enable = "\x1b[100m", disable = "\x1b[49m" },
	bgGrey          = { enable = "\x1b[100m", disable = "\x1b[49m" },

	--- bright bg
	bgBlackBright   = { enable = "\x1b[100m", disable = "\x1b[49m" },
	bgRedBright     = { enable = "\x1b[101m", disable = "\x1b[49m" },
	bgGreenBright   = { enable = "\x1b[102m", disable = "\x1b[49m" },
	bgYellowBright  = { enable = "\x1b[103m", disable = "\x1b[49m" },
	bgBlueBright    = { enable = "\x1b[104m", disable = "\x1b[49m" },
	bgMagentaBright = { enable = "\x1b[105m", disable = "\x1b[49m" },
	bgCyanBright    = { enable = "\x1b[106m", disable = "\x1b[49m" },
	bgWhiteBright   = { enable = "\x1b[107m", disable = "\x1b[49m" },
}

-- check if built codes are same as actual codes
for k, v in pairs(codemap) do
	assert(v.enable == codes[k].enable, "_codes[" .. k .. "].enable does not match built code")
	assert(v.disable == codes[k].disable, "_codes[" .. k .. "].disable does not match built code")
end
