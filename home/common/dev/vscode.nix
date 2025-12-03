{
  lib,
  pkgs,
  inputs,
  config,
  ...
}:
let
  vscode-marketplace = inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace;

  common-extensions = with vscode-marketplace; [
    bbenoist.nix # Nix language support for Visual Studio Code.
    jnoortheen.nix-ide # Nix language support - syntax highlighting, formatting, and error reporting.
    mkhl.direnv
    anthropic.claude-code
    shd101wyy.markdown-preview-enhanced
  ];
in
{
  home.packages = [
    pkgs.vscode
    pkgs.direnv
  ];

  programs.vscode = {
    enable = true;

    profiles.default.extensions =
      with vscode-marketplace;
      [
      ]
      ++ common-extensions;

    profiles.python.extensions =
      with vscode-marketplace;
      [
        ms-python.python
        ms-python.debugpy
        ms-python.vscode-python-envs
      ]
      ++ common-extensions;

    profiles.verilog.extensions =
      with vscode-marketplace;
      [
        ms-vscode.cmake-tools
        ms-vscode.cpptools
        ms-vscode.cpptools-extension-pack
        mshr-h.veriloghdl
      ]
      ++ common-extensions;
  };

  xdg.desktopEntries = builtins.listToAttrs (
    map (name: {
      name = "vscode-${name}";
      value = {
        name = "Visual Studio Code (${lib.strings.toUpper (lib.substring 0 1 name)}${
          lib.substring 1 (lib.stringLength name) name
        })";
        comment = "Code Editing. Redefined.";
        exec = "code --profile ${if name == "default" then "Default" else name} %F";
        icon = "vscode";
        type = "Application";
        categories = [
          "Utility"
          "TextEditor"
          "Development"
          "IDE"
        ];
        settings = {
          GenericName = "Text Editor";
          Keywords = "vscode";
          StartupNotify = "true";
          StartupWMClass = "Code";
          Version = "1.4";
        };
      };
    }) (builtins.attrNames config.programs.vscode.profiles)
  );
}
