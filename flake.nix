{
  description = "Minigrep in various languages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    haskell.url = "path:./haskell/";
    lua.url = "path:./lua/";
    nim.url = "path:./nim/";
    scheme.url = "path:./scheme/";
    rust.url = "path:./rust/";
    go.url = "path:./go/";
    elixir.url = "path:./elixir/";
    gleam.url = "path:./gleam/";
    java.url = "path:./java/";
    typescript.url = "path:./typescript/";
    cpp.url = "path:./cpp/";
    ocaml.url = "path:./ocaml/";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        haskell = inputs.haskell.packages."${system}".default;
        lua = inputs.lua.packages."${system}".default;
        nim = inputs.nim.packages."${system}".default;
        scheme = inputs.scheme.packages."${system}".default;
        rust = inputs.rust.packages."${system}".default;
        go = inputs.go.packages."${system}".default;
        elixir = inputs.elixir.packages."${system}".default;
        gleam = inputs.gleam.packages."${system}".default;
        java = inputs.java.packages."${system}".default;
        typescript = inputs.typescript.packages."${system}".default;
        cpp = inputs.cpp.packages."${system}".default;
        ocaml = inputs.ocaml.packages."${system}".default;
      };
    });
}
