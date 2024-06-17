//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
  {"", "music",     1,  15},
  {"", "weather",   60, 16},
  {"", "volume",    1,  10},
  {"", "micvolume", 1,  12},
  {"", "wifi",      5,  11},
  {"", "battery",   1,  13},
  {"", "datetime",  1,  14},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = "  ";
static unsigned int delimLen = 5;
