{ ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")
      local act = wezterm.action

      return {
        enable_tab_bar = false,
        force_reverse_video_cursor = true,
        font = wezterm.font_with_fallback({
          "monospace",
          { family = "Symbols Nerd Font Mono", scale = 0.75 },
        }),
        line_height = 0.975,
        warn_about_missing_glyphs = false,
        window_padding = {
          left = '2cell',
          right = '2cell',
          top = '0.75cell',
          bottom = '0.5cell',
        },
        keys = {
          { 
            mods = "SHIFT|CTRL",
            key = "U",
            action = act.QuickSelectArgs {
              label = "open uri",
              patterns = { "\\w+?://[a-zA-Z0-9+&@#/%?=~_|!:,.;]*[a-zA-Z0-9+&@#/%=~_|]" };
              action = wezterm.action_callback(function(window, pane)
                local url = window:get_selection_text_for_pane(pane)
                wezterm.log_info('opening: ' .. url)
                wezterm.open_with(url)
              end),
            } 
          },
        },
      }
    '';
  };
}
