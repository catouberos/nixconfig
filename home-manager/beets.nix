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
        relative_to = "${config.programs.beets.settings.directory}";
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
          {
            name = "THE IDOLM@STER CINDERELLA GIRLS.m3u";
            query = "THE IDOLM@STER CINDERELLA GIRLS";
          }
          {
            name = "ラブライブ！スーパースター!!.m3u";
            query = "artist:Liella,artist:唐可可,artist:平安名すみれ,artist:葉月恋,artist:澁谷かのん,artist:嵐千砂都,artist:KALEIDOSCORE,artist:ウィーン・マルガレーテ,artist:桜小路きな子,artist:鬼塚夏美,artist:若菜四季,artist:米女メイ,'artist:Sunny Passion',artist:鬼塚冬毬,artist:柊摩央,artist:聖澤悠奈";
          }
        ];
      };
    };
  };
}
