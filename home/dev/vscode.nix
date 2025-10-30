{
  lib,
  pkgs,
  inputs,
  ...
}:
{

  home.packages = [
    pkgs.vscode
  ];

  programs.vscode = {
    enable = true;

    profiles.default.extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
      bbenoist.nix # Nix language support for Visual Studio Code.
      jnoortheen.nix-ide # Nix language support - syntax highlighting, formatting, and error reporting.
    ];
  };

}
