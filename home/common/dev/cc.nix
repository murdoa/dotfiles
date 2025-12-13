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
    (lib.hiPrio clang)
    clang-tools
    cppcheck
  ];

}
