{
  pkgs,
  pkgs-deprecated,
  ...
}: {
  xdg.configFile."easyeffects/output" = {
    source = ../../../config/easyeffects/output;
    recursive = true;
  };

  xdg.configFile."mpd" = {
    source = ../../../config/mpd;
    recursive = true;
  };

  xdg.configFile."ncmpcpp" = {
    source = ../../../config/ncmpcpp;
    recursive = true;
  };

  xdg.configFile."mpv" = {
    source = ../../../config/mpv;
    recursive = true;
  };

  services.easyeffects = {
    enable = true;
    preset = "HD 58X";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.obs-vaapi
    ];
  };

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      autoload
      uosc
      mpris
      thumbfast
      videoclip
      webtorrent-mpv-hook
    ];
    scriptOpts = {
      videoclip = {
        video_folder_path = ".";
        audio_folder_path = ".";
      };
    };
  };

  home.packages = with pkgs; [
    musescore
    pavucontrol
    mpd
    ncmpcpp
    mpc-cli
    ffmpeg
    libvpx
    libvorbis
    mpdscribble
    gimp
    anki
    piper-tts
    (pkgs.callPackage ../../../packages/yt-dlp.nix {})
    gst_all_1.gstreamer
    gst_all_1.gstreamermm
    gst_all_1.gst-rtsp-server
    gst_all_1.gst-editing-services
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    gst_all_1.gst-vaapi
  ];
  # ++ (with pkgs-stable; [anki]);
}
