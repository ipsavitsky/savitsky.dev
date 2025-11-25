{
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
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            typst
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
              pandoc
              typst
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
