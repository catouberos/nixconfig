{
  config,
  pkgs,
  ...
}: {
  programs.beets = {
    enable = true;
    settings = {
      plugins = "fetchart embedart convert";
      directory = "/mnt/wdblue/Music";
      library = "${config.home.homeDirectory}/.beets/library.db";
      match = {
        strong_rec_thresh = 0.15;
      };
      fetchart = {
        maxwidth = 1024;
        max_filesize = 1000000;
      };
      sources = [
        "filesystem"
        {coverart = "release";}
        "itunes"
        {coverart = "releasegroup";}
      ];
      convert = {
        dest = "${config.home.homeDirectory}/Beets";
        format = "flacipod";
        formats = {
          flacipod = {
            command = "${pkgs.ffmpeg-full}/bin/ffmpeg -i $source -y -sample_fmt s16 -ar 44100 -vn -acodec flac $dest";
            extension = "flac";
          };
        };
      };
    };
  };
}
