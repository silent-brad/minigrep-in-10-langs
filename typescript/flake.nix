{
  description = "Minigrep in TypeScript";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.writers.writeBashBin "minigrep-ts" ''
          ${pkgs.nodejs}/bin/node ${./minigrep.ts} "$@"
        '';

        devShells.default = pkgs.mkShell { packages = with pkgs; [ nodejs ]; };
      });
}
