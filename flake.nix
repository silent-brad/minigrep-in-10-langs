{
  description = "Minigrep in 5 languages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    haskell.url = "path:./hs/";
    lua.url = "path:./lua/";
    nim.url = "path:./nim/";
    fennel.url = "path:./fennel/";
  };

  outputs = { self, nixpkgs, flake-utils, haskell, lua, nim, fennel }:
    flake-utils.lib.eachDefaultSystem (system: {
      packages = {
        haskell = haskell.packages."${system}".default;
        lua = lua.packages."${system}".default;
        nim = nim.packages."${system}".default;
        fennel = fennel.packages."${system}".default;
      };
    });
}
