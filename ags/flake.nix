{
  description = "Transpile ags ts into js";

  outputs = { self, nixpkgs, ... }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
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
          cp -r ./style $out
        '';
      };

    in with pkgs; {
      defaultPackage = appBuild;
      devShell = mkShell { buildInputs = [ bun ]; };
    };
}
