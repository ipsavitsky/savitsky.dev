{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    typst.url = "github:typst/typst";
    pandoc-nix.url = "github:jgm/pandoc";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      typst,
      pandoc-nix,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            typst.packages.${system}.default
            # pandoc-nix.packages.${system}.default
            pandoc
            just
          ];
        };
        packages = rec {
          default = savitsky-dev;
          savitsky-dev = pkgs.stdenv.mkDerivation {
            name = "savitsky.dev";
            src = ./.;
            nativeBuildInputs = with pkgs; [
              # pandoc-nix.packages.${system}.default
              pandoc
              typst.packages.${system}.default
            ];
            installPhase = ''
              mkdir -p $out/static
              pandoc resume/resume.typ -o static/resume.html
              typst compile resume/resume.typ static/resume.pdf
              cp -r static $out/
            '';
          };
        };
      }
    );
}
