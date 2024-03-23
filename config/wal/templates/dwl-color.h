/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    {{ ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }}

static const float rootcolor[]             = COLOR(0x{background.strip}ff);
static const float bordercolor[]           = COLOR(0x{color8.strip}ff);
static const float focuscolor[]            = COLOR(0x{color15.strip}ff);
static const float urgentcolor[]           = COLOR(0xff0000ff);

