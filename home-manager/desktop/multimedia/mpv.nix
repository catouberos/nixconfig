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
      volume = 80;

      # screenshot
      screenshot-format = "jpg";
      screenshot-jpeg-quality = 100;
      screenshot-directory = "${config.home.homeDirectory}/Pictures/mpv";
      screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";

      # yt-dlp
      ytdl-format = "bestvideo+bestaudio";
    };
  };
}
