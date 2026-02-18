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
            hash = "sha256-KHSfWsZHibJS52/5Tk5loBh38jiWd1H4pa4Om3mtI2k=";
          };

          build-system = [
            super.setuptools
          ];

          doCheck = false;
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
