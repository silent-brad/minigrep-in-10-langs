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
            ${pkgs.haskellPackages.ghc}/bin/ghc -o $out ${./app/Main.hs}
          '';
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cabal-install
            ghcid
            haskell-language-server
            hlint
            ormolu
            haskellPackages.ghc
          ];
          shellHook = ''
            echo "Haskell GHC: $(${pkgs.haskellPackages.ghc}/bin/ghc -v)"
            echo "Cabal: $(${pkgs.cabal-install}/bin/cabal --version)"
            echo "Run './result/bin/minigrep'."
          '';
        };
      });
}
