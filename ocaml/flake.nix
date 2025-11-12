{
  description = "Minigrep in OCaml";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "minigrep-in-ocaml";
          version = "0.0.1";
          src = ./.;

          buildInputs = with pkgs; [ ocaml dune_3 ];

          buildPhase = ''
            mkdir -p $out/bin
            ${pkgs.dune_3}/bin/dune build
            cp _build/default/bin/main.exe $out/bin/minigrep-ml
          '';
        };

        devShells.default =
          pkgs.mkShell { packages = with pkgs; [ ocaml dune_3 ]; };
      });
}
