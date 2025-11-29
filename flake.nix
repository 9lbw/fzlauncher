{
  description = "A fast, cached, fzf-powered application launcher for Linux desktops";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        fzlauncher = pkgs.stdenv.mkDerivation {
          pname = "fzlauncher";
          version = "1.1.0";

          src = ./.;

          nativeBuildInputs = [ pkgs.makeWrapper ];

          buildInputs = [ pkgs.python3 ];

          dontBuild = true;

          installPhase = ''
                    runHook preInstall

                    install -Dm755 fzlauncher $out/bin/fzlauncher

                    # Patch APP_DIRS to include NixOS-compatible paths
                    substituteInPlace $out/bin/fzlauncher \
                      --replace-fail 'APP_DIRS = [' 'APP_DIRS = [
            Path("/run/current-system/sw/share/applications"),
            Path(os.path.expanduser("~/.nix-profile/share/applications")),
            Path("/etc/profiles/per-user/" + os.environ.get("USER", "") + "/share/applications"),'

                    wrapProgram $out/bin/fzlauncher \
                      --prefix PATH : ${
                        pkgs.lib.makeBinPath [
                          pkgs.fzf
                          pkgs.bash
                        ]
                      }

                    runHook postInstall
          '';

          meta = with pkgs.lib; {
            description = "A fast, cached, fzf-powered application launcher for Linux desktops";
            homepage = "https://github.com/9lbw/fzlauncher";
            license = licenses.bsd2;
            platforms = platforms.linux;
            mainProgram = "fzlauncher";
          };
        };
      in
      {
        packages = {
          default = fzlauncher;
          fzlauncher = fzlauncher;
        };

        apps.default = {
          type = "app";
          program = "${fzlauncher}/bin/fzlauncher";
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            pkgs.python3
            pkgs.fzf
          ];
        };
      }
    );
}
