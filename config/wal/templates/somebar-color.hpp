#define COLOR(hex) Color((hex >> 16) & 0xFF, (hex >> 8) & 0xFF, hex & 0xFF)

constexpr ColorScheme colorInactive = {{COLOR(0x{foreground.strip}), COLOR(0x{background.strip})}};
constexpr ColorScheme colorActive = {{COLOR(0x{foreground.strip}), COLOR(0x{color2.strip})}};
