{
  description = "Minigrep in Rust";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "minigrep-in-rust";
          version = "0.0.1";
          src = ./.;

          buildInputs = with pkgs; [ rustPlatform.rust.rustc ];

          buildPhase = ''
            mkdir -p $out/bin
            ${pkgs.rustPlatform.rust.rustc}/bin/rustc -o $out/bin/minigrep-rs ${
              ./minigrep.rs
            }
          '';
        };

        devShells.default =
          pkgs.mkShell { packages = with pkgs; [ rustPlatform.rust.rustc ]; };
      });
}
