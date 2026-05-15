# dusk

A rich text formatting library for lua.

## Installation

Drag and drop `dusk.lua` into your project. The library can also be installed using luarocks.

```bash
luarocks install dusk
```

## Usage

Dusk provides a composable API which allows you to chain styles together.

```lua
local d = require("dusk")

-- chain styles together
print(d.red.bold("Hello, World!"))
```

Dusk's API also allows you to nest styles.

```lua
print(d.red.bold(d.underline("Felix"), d.strikethrough("was"), "here"))
```

Dusk provides multiple ways to define colors like rgb, hex, and ansi.

```lua
-- rgb
print(d.rgb(255, 0, 0).bgRgb(0, 255, 0))

-- hex
print(d.hex("#ff0000").bgHex("#00ff00"))

-- ansi
print(d.ansi(64).bgAnsi(128))
```

Dusk also allows storing a custom styles which can be reused or extended again. This allows creation of reusable style components.

```lua
local d = require("dusk")

-- create a base style
local base = d.red.bold

-- reuse the base style
print(base("Hello, World!"))

-- extend stored styles
print(base.underline("I'm underlined"))
print(base.strikethrough("I'm striked"))
```

## API

### `require("dusk").<style>[.<style>...](string, [string...])`

Chain styles together and call the last one with a string argument to apply the built styles to the string. If you chain multiple fg colors (or bg) then the last one will take precedence. Calling the api with multiple strings will join them together with spaces.

## Styles

### Modifiers

- `reset` - Reset the current style.
- `bold` - Make the text bold.
- `dim` - Make the text have lower opacity.
- `italic` - Make the text italic.
- `underline` - Put a horizontal line below the text.
- `blink` - Make the text blink.
- `inverse`- Invert background and foreground colors.
- `hidden` - Print the text but make it invisible.
- `strikethrough` - Puts a horizontal line through the center of the text.

### Colors

- `black`
- `red`
- `green`
- `yellow`
- `blue`
- `magenta`
- `cyan`
- `white`
- `blackBright` (alias: `gray`, `grey`)
- `redBright`
- `greenBright`
- `yellowBright`
- `blueBright`
- `magentaBright`
- `cyanBright`
- `whiteBright`

### Background Colors

- `bgBlack`
- `bgRed`
- `bgGreen`
- `bgYellow`
- `bgBlue`
- `bgMagenta`
- `bgCyan`
- `bgWhite`
- `bgBlackBright` (alias: `bgGray`, `bgGrey`)
- `bgRedBright`
- `bgGreenBright`
- `bgYellowBright`
- `bgBlueBright`
- `bgMagentaBright`
- `bgCyanBright`
- `bgWhiteBright`

## Terminal support

Dusk by default expects a modern terminal that supports ANSI escape codes. Dusk provides the `rgb` and `hex` color formats for true color and `ansi` color format for 256-color terminals.

## TODO

- Detect terminal caps and downsample when needed.
- `strip` style
- `overline` style

## Thanks

Dusk is heavily inspired by [chalk](https://github.com/chalk/chalk).
