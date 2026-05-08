local d = require("dusk")
local codes = getmetatable(d)._codes

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
local rgb = codes.rgb(d)(255, 0, 0)[1]
assert(rgb.enable == ("\27[38;2;%d;%d;%dm"):format(255, 0, 0))
assert(rgb.disable == "\27[39m")
assert(d.rgb(255, 0, 0)("test") == ""
	.. rgb.enable
	.. "test"
	.. rgb.disable,
	"rgb")

local bgRgb = codes.bgRgb(d)(255, 0, 0)[1]
assert(bgRgb.enable == ("\27[48;2;%d;%d;%dm"):format(255, 0, 0))
assert(bgRgb.disable == "\27[49m")
assert(d.bgRgb(255, 0, 0)("test") == ""
	.. bgRgb.enable
	.. "test"
	.. bgRgb.disable,
	"bgRgb")
