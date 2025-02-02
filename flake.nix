{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {

      packages.x86_64-linux.savitsky-dev = pkgs.stdenv.mkDerivation {
        name = "savitsky.dev";
        src = ./.;
        installPhase = ''
          mkdir -p $out/static
          cp index.html $out/static
        '';
      };
    };
}
