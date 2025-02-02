{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = rec {
          default = savitsky-dev;
          savitsky-dev = pkgs.stdenv.mkDerivation {
            name = "savitsky.dev";
            src = ./.;
            installPhase = ''
              mkdir -p $out/static
              cp index.html $out/static
            '';
          };
        };
      }
    );
}
