{
  description = "Minigrep in Java";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "minigrep-in-java";
          version = "0.0.1";
          src = ./.;

          buildInputs = with pkgs; [ jdk17 ];

          buildPhase = ''
            mkdir -p $out/bin
            ${pkgs.jdk17}/bin/javac -d $out/bin ${./minigrep.java}
            cat > $out/bin/minigrep-java << EOF
            ${pkgs.jdk17}/bin/java -cp $out/bin Minigrep "\$@"
            EOF
            chmod +x $out/bin/minigrep-java
          '';
        };

        devShells.default = pkgs.mkShell { packages = with pkgs; [ jdk17 ]; };
      });
}
