{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  naersk' = pkgs.callPackage inputs.naersk {};

  mpv-websocket = naersk'.buildPackage {
    src = pkgs.fetchFromGitHub {
      owner = "kuroahna";
      repo = "mpv_websocket";
      rev = "0.2.0";
      hash = "sha256-yqZdLCAv9hP6ZMuNcgy2w8CYK/cNGMwpCE/0s2ELNTA=";
    };
  };
in {
  home.packages = [
    mpv-websocket
  ];

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      autoload
      sponsorblock
      (lib.mkIf pkgs.stdenv.isLinux mpvacious)
      mpv-webm
      autosubsync-mpv
    ];
    scriptOpts = {
      webm = {
        output_directory = "${config.home.homeDirectory}/Videos";
      };
      subs2srs = {
        use_ffmpeg = "yes";
        snapshot_format = "webp";
        # https://arbyste.github.io/jp-mining-note-prerelease/setupmpvacious/
        model_name = "JP Mining Note";
        sentence_field = "Sentence";
        audio_field = "SentenceAudio";
        image_field = "Picture";
        audio_bitrate = "32k";
        snapshot_quality = "50";
        snapshot_width = "800";
        snapshot_height = "-2";
      };
    };
    config = {
      # general
      keep-open = true;
      fullscreen = true;
      save-position-on-quit = true;

      # video
      alang = "ja,jp";
      slang = "enm,nm,eng";
      profile = "high-quality";
      hwdec = "auto";
      vo = "gpu,libmpv";

      # subtitles
      sub-font = "IBM Plex Sans JP";
      sub-auto = "fuzzy";
      sub-file-paths = "${config.home.homeDirectory}/Downloads";
      sub-fix-timing = true;
      demuxer-mkv-subtitle-preroll = true;

      # audio
      ao = "pulse,avfoundation,coreaudio";
      volume = 80;

      # screenshot
      screenshot-format = "jpg";
      screenshot-jpeg-quality = 100;
      screenshot-directory = "${config.home.homeDirectory}/Pictures/mpv";
      screenshot-template = "%f-%wH.%wM.%wS.%wT-#%#00n";

      # yt-dlp
      ytdl-format = "bestvideo+bestaudio";

      input-ipc-server = "/tmp/mpv";
    };
  };
}
