{
  description = "Minigrep in Lua";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default =
          pkgs.writers.writeLuaBin "minigrep-lua" { } ./minigrep.lua;

        devShells.default = pkgs.mkShell { packages = with pkgs; [ luajit ]; };
      });
}
