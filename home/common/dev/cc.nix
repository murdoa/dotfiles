{
  lib,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    gcc15
    gnumake
    cmake
    pkg-config
    gdb
    valgrind
    (hiPrio clang)
    clang-tools
    cppcheck
  ];

}
