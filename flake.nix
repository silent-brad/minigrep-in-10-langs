{
  description = "Minigrep in 5 languages";

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
  };

  outputs =
    { self, nixpkgs, flake-utils, haskell, lua, nim, scheme, rust, go, elixir }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        haskell = haskell.packages."${system}".default;
        lua = lua.packages."${system}".default;
        nim = nim.packages."${system}".default;
        scheme = scheme.packages."${system}".default;
        rust = rust.packages."${system}".default;
        go = go.packages."${system}".default;
        elixir = elixir.packages."${system}".default;
      };
    });
}
