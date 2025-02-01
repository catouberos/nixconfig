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
            query = [
              "artist:星見プロダクション"
              "artist:TRINITYAiLE"
              "artist:サニーピース"
              "artist:LizNoir"
              "artist:月のテンペスト"
              "artist:ⅢX"
              "album:IDOLY PRIDE"
            ];
          }
          {
            name = "ONGEKI.m3u";
            query = "ONGEKI";
          }
          {
            name = "THE IDOLM@STER CINDERELLA GIRLS.m3u";
            query = "THE IDOLM@STER CINDERELLA GIRLS";
          }
          {
            name = "ラブライブ！.m3u";
            query = [
              "artist:μ’s"
              "artist:高坂穂乃果"
              "artist:南ことり"
              "artist:園田海未"
              "artist:小泉花陽"
              "artist:星空凛"
              "artist:西木野真姫"
              "artist:矢澤にこ"
              "artist:絢瀬絵里"
              "artist:東條希"
              "artist:Printemps"
              "artist:BiBi"
              "artist:lily white"
            ];
          }
          {
            name = "ラブライブ！スーパースター!!.m3u";
            query = [
              "artist:Liella"
              "artist:唐可可"
              "artist:平安名すみれ"
              "artist:葉月恋"
              "artist:澁谷かのん"
              "artist:嵐千砂都"
              "artist:ウィーン・マルガレーテ"
              "artist:桜小路きな子"
              "artist:鬼塚夏美"
              "artist:若菜四季"
              "artist:米女メイ"
              "artist:鬼塚冬毬"
              "artist:柊摩央"
              "artist:聖澤悠奈"
              "artist:CatChu!"
              "artist:5yncri5e!"
              "artist:KALEIDOSCORE"
              "artist:Sunny Passion"
            ];
          }
          {
            name = "ラブライブ！サンシャイン!!.m3u";
            query = [
              "artist:Aqours"
              "artist:高海千歌"
              "artist:桜内梨子"
              "artist:渡辺曜"
              "artist:黒澤ダイヤ"
              "artist:小原鞠莉"
              "artist:津島善子"
              "artist:松浦果南"
              "artist:国木田花丸"
              "artist:黒澤ルビィ"
              "artist:CYaRon!"
              "artist:AZALEA"
              "artist:Guilty Kiss"
              "artist:Saint Snow"
              "artist:わいわいわい"
            ];
          }
          {
            name = "ラブライブ！虹ヶ咲学園スクールアイドル同好会.m3u";
            query = [
              "artist:虹ヶ咲学園スクールアイドル同好会"
              "artist:上原歩夢"
              "artist:中須かすみ"
              "artist:優木せつ菜"
              "artist:宮下愛"
              "artist:エマ・ヴェルデ"
              "artist:天王寺璃奈"
              "artist:近江彼方"
              "artist:桜坂しずく"
              "artist:朝香果林"
              "artist:鐘嵐珠"
              "artist:三船栞子"
              "artist:ミア・テイラー"
              "artist:DiverDiva"
              "artist:QU4RTZ"
              "artist:A・ZU・NA"
            ];
          }
          # INCOMPLETE
          {
            name = "アイカツ!.m3u";
            query = [
              "album:アイカツ"
              "artist:STAR☆ANIS"
              "artist:AIKATSU☆STARS!"
              "artist:STARRY PLANET☆"
              "artist:BEST FRIENDS!"
              "artist:わか"
              "artist:ふうり"
              "artist:ゆな"
              "artist:れみ"
              "artist:えり"
              "artist:りすこ"
              "artist:るか"
              "artist:りえ"
              "artist:みき"
              "artist:せな"
              "artist:ななせ"
              "artist:かな"
            ];
          }
        ];
      };
    };
  };
}
