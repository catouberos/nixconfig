{
  pkgs,
  config,
  ...
}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      autoload
      sponsorblock
      mpvacious
      mpv-webm
    ];
    scriptOpts = {
      webm = {
        output_directory = "${config.home.homeDirectory}/Videos";
      };
    };
    config = {
      # general
      keep-open = true;
      fullscreen = true;
      save-position-on-quit = true;

      # video
      alang = ["ja" "jp" "jpn" "en" "eng"];
      slang = ["enm" "en" "eng"];
      demuxer-mkv-subtitle-preroll = true;
      sub-ass-vsfilter-blur-compat = true;
      sub-fix-timing = true;
      sub-auto = "fuzzy";
      profile = "high-quality";
      hwdec = "auto";
      vo = "gpu-next";

      # audio
      volume = 75;

      # screenshot
      screenshot-format = "png";
      screenshot-png-compression = 7;
      screenshot-directory = "${config.home.homeDirectory}/Pictures";
      screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";

      # yt-dlp
      ytdl-format = "bestvideo+bestaudio";
    };
  };
}
