{
  description = "Minigrep in Haskell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "minigrep-in-haskell";
          version = "0.0.1";
          src = ./.;

          buildInputs = with pkgs; [ haskellPackages.ghc ];

          buildPhase = ''
            mkdir -p $out/bin
            ${pkgs.haskellPackages.ghc}/bin/ghc -o $out/bin/minigrep-hs ${
              ./minigrep.hs
            }
          '';
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            haskellPackages.ghc
            ghcid
            haskell-language-server
            hlint
            ormolu
          ];
        };
      });
}
