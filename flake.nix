{
  description = "NixOS configuration flake for dev machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      # Follow corresponding `release` branch from Home Manager
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    elephant.url = "github:abenz1267/elephant";

    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    ssh-keys = {
      url = "https://github.com/murdoa.keys";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nixos-hardware,
      ssh-keys,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      mainUser = "aodhan";
      overlays = [
        (final: prev: {
          grec = final.callPackage ./pkgs/grec.nix { };
        })
        (import ./home/overlays/bambu.nix)
      ];
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = overlays;
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;

      # nixos referres to hostname
      nixosConfigurations = {
        nixos-desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos-desktop/configuration.nix
          ];
          specialArgs = {
            inherit mainUser ssh-keys;
          };
        };
        nixos-laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/nixos-laptop/configuration.nix
            nixos-hardware.nixosModules.dell-latitude-7390
          ];
          specialArgs = {
            inherit mainUser ssh-keys;
          };
        };
      };

      homeConfigurations = {
        "aodhan@nixos-desktop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/aodhan-nixos-desktop.nix ];
          extraSpecialArgs = { inherit inputs system; };
        };
        "aodhan@nixos-laptop" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./home/aodhan-nixos-laptop.nix ];
          extraSpecialArgs = { inherit inputs system; };
        };
      };
    };
}
