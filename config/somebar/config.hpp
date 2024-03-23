// somebar - dwl bar
// See LICENSE file for copyright and license details.

#pragma once
#include "common.hpp"
#include "color.hpp"

constexpr bool topbar = true;

constexpr int paddingX = 10;
constexpr int paddingY = 3;

// See https://docs.gtk.org/Pango/type_func.FontDescription.from_string.html
constexpr const char* font = "monospace, Siji 9";

constexpr Button buttons[] = {
  { ClkTagBar,       BTN_LEFT,   view,       {0} },
 	{ ClkTagBar,       BTN_RIGHT,  tag,        {0} },
 	{ ClkTagBar,       BTN_MIDDLE, toggletag,  {0} },
 	{ ClkLayoutSymbol, BTN_LEFT,   setlayout,  {.ui = 0} },
 	{ ClkLayoutSymbol, BTN_RIGHT,  setlayout,  {.ui = 2} },
};
