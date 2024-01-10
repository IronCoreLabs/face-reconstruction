{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # nix develop
        devShell = pkgs.mkShell {
          buildInputs = with pkgs;
            [
              pkg-config
              pkgs.python310
              pkgs.hatch
              pkgs.zlib
            ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin
              [ pkgs.darwin.apple_sdk.frameworks.SystemConfiguration ];
        };

      });
}
