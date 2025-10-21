{
  description = "Minigrep in Go";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.buildGoModule {
          pname = "minigrep-in-go";
          version = "0.0.1";
          src = ./.;

          vendorHash = null;
          doCheck = false;
        };

        devShells.default = pkgs.mkShell { packages = with pkgs; [ go_1_25 ]; };
      });
}
