{
  description = "Minigrep in Elixir";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.writers.writeBash "minigrep-elixir" ''
          #!${pkgs.runtimeShell}
          ${pkgs.elixir_1_18}/bin/elixir minigrep.exs "$@"
        '';
        devShell =
          pkgs.mkShell { buildInputs = with pkgs; [ erlang elixir_1_18 ]; };
      });
}
