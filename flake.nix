{
  description = "Master's thesis LaTeX environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};

      # hand-pick TeX packages - texliveFull is huge
      tex = pkgs.texlive.combine {
        inherit
          (pkgs.texlive)
          # minimal texlive distribution
          scheme-small
          # build automation
          latexmk
          # bibliography
          biber
          biblatex
          biblatex-ieee
          logreq
          csquotes
          # language & localization
          babel-english
          babel-polish
          polski
          # code listings - minted & its dependencies or supporting packages
          minted
          fvextra
          upquote
          xstring
          lineno
          caption
          etoolbox
          xcolor
          # math & symbols
          amsfonts
          amsmath
          ;
      };

      # minted needs pygments
      pythonEnv = pkgs.python3.withPackages (ps: [ps.pygments]);
    in {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = [
          tex
          pythonEnv
          pkgs.texlab
          pkgs.gnumake
          pkgs.which
          pkgs.ghostscript
        ];
      };
    });
}
