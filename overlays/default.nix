{...}: {
  # overlays
  modifications = final: prev: rec {
    # transmission_4 = prev.transmission_4.overrideAttrs {
    #   version = "4.0.5";
    # };

    # nix-shell -p python.pkgs.my_stuff
    python3 = prev.python3.override {
      # Careful, we're using a different self and super here!
      packageOverrides = self: super: {
        pybambu = super.buildPythonPackage rec {
          pname = "pybambu";
          version = "1.0.1";
          pyproject = true;

          src = super.fetchPypi {
            inherit pname version;
            hash = "";
          };

          build-system = [super.setuptools];

          doCheck = false;
        };

        requests-doh = super.buildPythonPackage rec {
          pname = "requests-doh";
          version = "1.0.0";
          pyproject = true;

          src = prev.fetchFromGitHub {
            owner = "mansuf";
            repo = "requests-doh";
            rev = "v${version}";
            hash = "sha256-K1pesiCdDcRQinuZ1KZGBDnbHU3C+o/29FN/opb0lgw=";
          };

          build-system = [super.setuptools];

          propagatedBuildInputs = let
            requests = super.requests.overrideAttrs rec {
              version = "2.32.3";

              src = super.requests.src.override {
                tag = "v${version}";
                hash = "sha256-+RAPd/l+mwdmz1yAYZ/0gwHpFm91/dFVGlC2cjEAAKg=";
              };
            };
            dnspython = super.dnspython.overrideAttrs rec {
              version = "2.6.1";

              src = super.dnspython.src.override {
                inherit version;
                hash = "sha256-6PD5wjp7fLmd7WTmw6bz5wHXj1DFXgArg53qciXP98w=";
              };
            };
          in [requests requests.optional-dependencies.socks dnspython dnspython.optional-dependencies.doh];
        };

        pillow11 = super.pillow.overrideAttrs rec {
          version = "11.1.0";

          src = super.pillow.src.override {
            tag = version;
            hash = "sha256-9tcukZIJMheVNBfpppjUcuhvRal7J59iQWgBqkEgJDk=";
          };

          pytestFlagsArray = [];
          preConfigure = let
            getLibAndInclude = pkg: ''"${pkg.out}/lib", "${super.lib.getDev pkg}/include"'';
          in ''
            # The build process fails to find the pkg-config files for these dependencies
            substituteInPlace setup.py \
              --replace-fail 'IMAGEQUANT_ROOT = None' 'IMAGEQUANT_ROOT = ${getLibAndInclude prev.libimagequant}' \
              --replace-fail 'JPEG2K_ROOT = None' 'JPEG2K_ROOT = ${getLibAndInclude prev.openjpeg}'

            # Build with X11 support
            export LDFLAGS="$LDFLAGS -L${prev.libxcb}/lib"
            export CFLAGS="$CFLAGS -I${prev.libxcb.dev}/include"
          '';
        };
      };
    };
    python3Packages = prev.lib.recurseIntoAttrs (python3.pkgs);

    bambu-go2rtc = prev.python3Packages.buildPythonApplication rec {
      pname = "bambu-go2rtc";
      version = "a6418dc619af7cef6a1d2573bd32c9f4dc9d7006";
      pyproject = false;

      src = prev.fetchFromGitHub {
        owner = "synman";
        repo = "bambu-go2rtc";
        rev = version;
        sha256 = "sha256-jvOJCy9Yg3tJnSdDuW80042wlEmJSguv2n9ytq+HWkI=";
      };

      installPhase = ''install -Dm755 camera-stream.py $out/bin/bambu-go2rtc'';
    };

    mangadex-downloader = prev.python3Packages.buildPythonApplication rec {
      pname = "mangadex-downloader";
      version = "a0c28102bcb3e18c478044cc08bdd82bc3d3a884";
      pyproject = true;

      src = prev.fetchFromGitHub {
        owner = "mansuf";
        repo = "mangadex-downloader";
        rev = version;
        sha256 = "sha256-YqH7VwaPN6L3D31c3NsDt1tJ07+w7AFqneFQkCe54io=";
      };

      build-system = with final.python3Packages; [setuptools];

      dependencies = with final.python3Packages; [
        tqdm
        pathvalidate
        packaging
        pyjwt
        beautifulsoup4
        chardet
        pillow11
        requests-doh
      ];
    };

    octoprint = prev.octoprint.override {
      packageOverrides = self: super: {
        octoprint-bambuprinter = self.buildPythonPackage rec {
          pname = "BambuPrinter";
          version = "0.1.8rc16";
          format = "setuptools";
          src = prev.fetchFromGitHub {
            owner = "jneilliii";
            repo = "OctoPrint-BambuPrinter";
            rev = version;
            sha256 = "sha256-DIu9K5bwwCfs817hV6YHBRRe8gku5QEBmRYzg8UTsTc=";
          };
          propagatedBuildInputs = [
            python3.pkgs.pybambu
            super.python.pkgs.paho-mqtt
            super.python.pkgs.python-dateutil
            super.python.pkgs.cloudscraper
            super.octoprint
          ];
          doCheck = false;
        };
      };
    };
  };
}
