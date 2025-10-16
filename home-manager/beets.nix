{
  config,
  pkgs,
  ...
}: {
  programs.beets = {
    enable = true;
    settings = {
      plugins = "musicbrainz fetchart embedart convert zero mbsync fish smartplaylist lyrics";
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
      lyrics = {
        sources = "lrclib";
        synced = "yes";
      };
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
            query = "album: ONGEKI ^title:\"Game Size\" ^title:\"instrumental\" ^title:\"ver.-\"";
          }
          {
            name = "ONGEKI Vocal Collection.m3u";
            query = "album: ONGEKI Vocal Collection ^title:\"Game Size\" ^title:\"instrumental\" ^title:\"ver.-\"";
          }
          {
            name = "ONGEKI Vocal Party.m3u";
            query = "album: ONGEKI Vocal Party ^title:\"Game Size\" ^title:\"instrumental\" ^title:\"ver.-\"";
          }
          {
            name = "ONGEKI Sound Collection.m3u";
            query = "album: ONGEKI Sound Collection";
          }
          {
            name = "ONGEKI Memorial Soundtrack.m3u";
            query = "album: ONGEKI Memorial Soundtrack";
          }

          {
            name = "THE IDOLM@STER CINDERELLA GIRLS.m3u";
            query = "THE IDOLM@STER CINDERELLA GIRLS ^title:\"オリジナル・カラオケ\" ^title:\"Game Version\" ^title:\"リミックス\" ^title:\"TV SIZE\" ^album:\"ORIGINAL SOUNDTRACK\" ^artist:\"[dialogue]\"";
          }
          {
            name = "THE IDOLM@STER SHINY COLORS.m3u";
            query = "THE IDOLM@STER SHINY COLORS ^title:\"Off Vocal\" ^title:\"Game Size\"";
          }

          {
            name = "ウマ娘 プリティーダービー.m3u";
            query = "ウマ娘 プリティーダービー ^title:\"Off Vocal\" ^title:\"Game Size\" ^title:\"TV Size\" ^album::\"WINNING LIVE (25|17|12|06)\" ^releasetype:soundtrack";
          }
          {
            name = "ラブライブ！.m3u";
            query = [
              "artist:μ’s ^title:\"Off Vocal\""
              "artist:高坂穂乃果 ^title:\"Off Vocal\""
              "artist:南ことり ^title:\"Off Vocal\""
              "artist:園田海未 ^title:\"Off Vocal\""
              "artist:小泉花陽 ^title:\"Off Vocal\""
              "artist:星空凛 ^title:\"Off Vocal\""
              "artist:西木野真姫 ^title:\"Off Vocal\""
              "artist:矢澤にこ ^title:\"Off Vocal\""
              "artist:絢瀬絵里 ^title:\"Off Vocal\""
              "artist:東條希 ^title:\"Off Vocal\""
              "artist:Printemps ^title:\"Off Vocal\""
              "artist:BiBi ^title:\"Off Vocal\""
              "artist:lily white ^title:\"Off Vocal\""
            ];
          }
          {
            name = "ラブライブ！スーパースター!!.m3u";
            query = [
              "artist:Liella ^title:\"Off Vocal\""
              "artist:唐可可 ^title:\"Off Vocal\""
              "artist:平安名すみれ ^title:\"Off Vocal\""
              "artist:葉月恋 ^title:\"Off Vocal\""
              "artist:澁谷かのん ^title:\"Off Vocal\""
              "artist:嵐千砂都 ^title:\"Off Vocal\""
              "artist:ウィーン・マルガレーテ ^title:\"Off Vocal\""
              "artist:桜小路きな子 ^title:\"Off Vocal\""
              "artist:鬼塚夏美 ^title:\"Off Vocal\""
              "artist:若菜四季 ^title:\"Off Vocal\""
              "artist:米女メイ ^title:\"Off Vocal\""
              "artist:鬼塚冬毬 ^title:\"Off Vocal\""
              "artist:柊摩央 ^title:\"Off Vocal\""
              "artist:聖澤悠奈 ^title:\"Off Vocal\""
              "artist:CatChu! ^title:\"Off Vocal\""
              "artist:5yncri5e! ^title:\"Off Vocal\""
              "artist:KALEIDOSCORE ^title:\"Off Vocal\""
              "artist:Sunny Passion ^title:\"Off Vocal\""
            ];
          }
          {
            name = "ラブライブ！サンシャイン!!.m3u";
            query = [
              "artist:Aqours ^title:\"Off Vocal\""
              "artist:高海千歌 ^title:\"Off Vocal\""
              "artist:桜内梨子 ^title:\"Off Vocal\""
              "artist:渡辺曜 ^title:\"Off Vocal\""
              "artist:黒澤ダイヤ ^title:\"Off Vocal\""
              "artist:小原鞠莉 ^title:\"Off Vocal\""
              "artist:津島善子 ^title:\"Off Vocal\""
              "artist:松浦果南 ^title:\"Off Vocal\""
              "artist:国木田花丸 ^title:\"Off Vocal\""
              "artist:黒澤ルビィ ^title:\"Off Vocal\""
              "artist:CYaRon! ^title:\"Off Vocal\""
              "artist:AZALEA ^title:\"Off Vocal\""
              "artist:Guilty Kiss ^title:\"Off Vocal\""
              "artist:Saint Snow ^title:\"Off Vocal\""
              "artist:わいわいわい ^title:\"Off Vocal\""
            ];
          }
          {
            name = "ラブライブ！虹ヶ咲学園スクールアイドル同好会.m3u";
            query = [
              "artist:虹ヶ咲学園スクールアイドル同好会 ^title:\"Off Vocal\""
              "artist:上原歩夢 ^title:\"Off Vocal\""
              "artist:中須かすみ ^title:\"Off Vocal\""
              "artist:優木せつ菜 ^title:\"Off Vocal\""
              "artist:宮下愛 ^title:\"Off Vocal\""
              "artist:エマ・ヴェルデ ^title:\"Off Vocal\""
              "artist:天王寺璃奈 ^title:\"Off Vocal\""
              "artist:近江彼方 ^title:\"Off Vocal\""
              "artist:桜坂しずく ^title:\"Off Vocal\""
              "artist:朝香果林 ^title:\"Off Vocal\""
              "artist:鐘嵐珠 ^title:\"Off Vocal\""
              "artist:三船栞子 ^title:\"Off Vocal\""
              "artist:ミア・テイラー ^title:\"Off Vocal\""
              "artist:DiverDiva ^title:\"Off Vocal\""
              "artist:QU4RTZ ^title:\"Off Vocal\""
              "artist:A・ZU・NA ^title:\"Off Vocal\""
            ];
          }
          {
            name = "ラブライブ！蓮ノ空女学院スクールアイドルクラブ.m3u";
            query = [
              "artist:蓮ノ空女学院スクールアイドルクラブ ^title:\"Off Vocal\""
              "artist:DOLLCHESTRA ^title:\"Off Vocal\""
              "artist:スリーズブーケ ^title:\"Off Vocal\""
              "artist:みらくらぱーく! ^title:\"Off Vocal\""
              "artist:かほめぐ♡じぇらーと ^title:\"Off Vocal\""
              "artist:るりのとゆかいなつづりたち ^title:\"Off Vocal\""
            ];
          }
          {
            name = "田中秀和.m3u";
            query = "composer:田中秀和 ^releasetype:soundtrack";
          }
        ];
      };
    };
  };
}
