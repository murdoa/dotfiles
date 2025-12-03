{
  lib,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    treefmt
    nixfmt-rfc-style
  ];

}
