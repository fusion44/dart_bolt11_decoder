{
  description = "Jaspr Flutter Dev Environment";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShell = with pkgs;
        mkShell rec {
          buildInputs = [
            alejandra
            at-spi2-core.dev
            clang
            cmake
            dart
            dbus.dev
            flutter
            gtk3
            libdatrie
            libepoxy.dev
            libselinux
            libsepol
            libthai
            libxkbcommon
            ninja
            pcre
            pkg-config
            util-linux.dev
            xorg.libXdmcp
            xorg.libXtst
          ];

          shellHook = ''
            echo "Adding \$HOME/.pub-cache/bin to \$PATH"
            export PATH="$PATH":"$HOME/.pub-cache/bin"
            echo "Disabling Dart analytics"
            dart --disable-analytics > /dev/null
            echo "Disabling Flutter analytics"
            flutter --disable-analytics > /dev/null
          '';
        };
    });
}
