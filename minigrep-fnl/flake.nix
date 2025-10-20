{
  description = "Minigrep in Fennel";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fennel-file = {
      url = "https://fennel-lang.org/downloads/fennel-1.5.3.lua";
      type = "file";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-utils, fennel-file }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "minigrep-in-fennel";
          version = "0.0.1";
          src = ./.;

          buildInputs = with pkgs; [ luajit luajitPackages.fennel ];

          buildPhase = ''
            cp ${pkgs.luajitPackages.fennel}/share/lua/5.1/fennel.lua ./fennal.lua
          '';

          #nativeBuildInputs = with pkgs; [ makeWrapper ];
          installPhase = ''
            cat > $out <<EOF
            #!/usr/bin/env ${pkgs.bash}/bin/bash
            ${pkgs.luajit}/bin/lua -e "require(\"fennel\").install().dofile(\"minigrep.fnl\")(\"\$1\", \"\$2\")"
            EOF
            chmod +x $out
            # wrapProgram \$out --prefix PATH : $\{
            #  pkgs.lib.makeBinPath [ pkgs.luajit pkgs.luajitPackages.fennel ]
            #}
          '';

        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            luajit
            luajitPackages.fennel
            fennel-ls
            fnlfmt
          ];
          shellHook = ''
            echo "LuaJIT: $(${pkgs.luajit}/bin/luajit -v)"
            echo "Fennel: $(${pkgs.luajitPackages.fennel}/bin/fennel -v)"
            echo "Run './result/bin/minigrep'."
          '';
        };
      });
}
