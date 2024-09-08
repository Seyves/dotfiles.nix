{
  description = "Transpile ags ts into js";

  inputs = { flake-utils.url = "github:numtide/flake-utils"; };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        bun = pkgs.bun;

        appBuild = pkgs.stdenv.mkDerivation {
          name = "build-ags";
          version = "0.1.0";
          src = ./.;
          buildInputs = [ bun ];
          # https://nixos.org/manual/nixpkgs/stable/#sec-stdenv-phases
          buildPhase = ''
            bun build --outdir dist config.ts
          '';
          installPhase = ''
            ls
            cp -r ./dist $out
          '';
        };

      in with pkgs; {
        defaultPackage = appBuild;
        devShell = mkShell { buildInputs = [ bun ]; };
      });
}
