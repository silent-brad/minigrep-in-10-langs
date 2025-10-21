{
  description = "Minigrep in Gleam";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.writers.writeBash "minigrep-gleam" ''
          #!${pkgs.runtimeShell}
          ${pkgs.gleam}/bin/gleam run src/minigrep.gleam "$@"
        '';
        devShell = pkgs.mkShell { buildInputs = with pkgs; [ erlang gleam ]; };
      });
}
