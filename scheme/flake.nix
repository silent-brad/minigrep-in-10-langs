{
  description = "Minigrep in Scheme";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "minigrep-in-scheme";
          version = "0.0.1";
          src = ./.;

          buildInputs = with pkgs; [ chicken ];

          buildPhase = ''
            mkdir -p $out/bin
            ${pkgs.chicken}/bin/csc -o $out/bin/minigrep-scm ${./minigrep.scm}
          '';
        };

        devShells.default = pkgs.mkShell { packages = with pkgs; [ chicken ]; };
      });
}
