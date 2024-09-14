{config, ...}: {
  programs.beets = {
    enable = true;
    settings = {
      plugins = "fetchart embedart convert zero mbsync";
      directory = "/mnt/samsung860/Music";
      library = "${config.home.homeDirectory}/.beets/library.db";
      match = {
        strong_rec_thresh = 0.15;
      };
      fetchart = {
        maxwidth = 1024;
        max_filesize = 1000000;
        sources = [
          "filesystem"
          {coverart = "release";}
          "itunes"
          {coverart = "releasegroup";}
        ];
      };
      zero = {
        fields = "comments";
        comments = [
          "[rR]ipped by"
          "cyanrip"
        ];
        update_database = true;
      };
    };
  };
}
