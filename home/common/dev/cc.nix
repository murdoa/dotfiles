{
  lib,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    cmake
    pkg-config
    gdb
    valgrind
    clang
    clang-tools
    cppcheck
  ];

}
