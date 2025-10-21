{
  description = "Minigrep in C++";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "minigrep-in-c++";
          version = "0.0.1";
          src = ./.;

          buildInputs = with pkgs; [ gcc ];

          buildPhase = ''
            mkdir -p $out/bin
            ${pkgs.gcc}/bin/g++ -o $out/bin/minigrep-cpp ${./minigrep.cpp}
          '';
        };

        devShells.default = pkgs.mkShell { packages = with pkgs; [ gcc ]; };
      });
}
