{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # nixos referres to hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        # Import the previous configuration.nix
        ./configuration.nix
      ];
    };
  };
}
