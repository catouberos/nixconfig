{config, ...}: {
  programs.beets = {
    enable = true;
    settings = {
      plugins = "fetchart embedart convert zero mbsync fish smartplaylist";
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
          "[dD]ownloaded"
        ];
        update_database = true;
      };
      smartplaylist = {
        playlist_dir = "${config.programs.beets.settings.directory}";
        playlists = [
          {
            name = "Blue Archive Soundtrack.m3u";
            query = "'album::Blue Archive.*(Soundtrack|OST)'";
          }
          {
            name = "IDOLY PRIDE.m3u";
            query = "artist:星見プロダクション , artist:TRINITYAiLE , artist:サニーピース , artist:LizNoir , artist:月のテンペスト , artist:ⅢX , 'album:IDOLY PRIDE'";
          }
          {
            name = "ONGEKI.m3u";
            query = "ONGEKI";
          }
          {
            name = "ONGEKI Vocal Collection.m3u";
            query = "ONGEKI Vocal Collection";
          }
          {
            name = "ONGEKI Vocal Party.m3u";
            query = "ONGEKI Vocal Party";
          }
          {
            name = "ONGEKI Sound Collection.m3u";
            query = "ONGEKI Sound Collection";
          }
          {
            name = "ONGEKI Memorial Soundtrack.m3u";
            query = "ONGEKI Memorial Soundtrack";
          }
        ];
      };
    };
  };
}
