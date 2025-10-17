# {
#   description = "Common flake to unify nixpkgs for system + home";

#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
#     nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
#     home-manager.url = "github:nix-community/home-manager/release-25.05";
#     home-manager.inputs.nixpkgs.follows = "nixpkgs";

#     system.url = "github:alex-kumpula/system-config";
#     home.url = "github:alex-kumpula/home-config";

#     system.inputs.nixpkgs.follows = "nixpkgs";
#     system.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
#     home.inputs.nixpkgs.follows = "nixpkgs";
#     home.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
#     home.inputs.home-manager.follows = "home-manager";
#   };

#   outputs = { self, nixpkgs, system, home, ... }: {
#     nixosConfigurations = system.nixosConfigurations;
#     homeConfigurations = home.homeConfigurations;
#   };
# }

{
  description = "Common flake to unify nixpkgs for system + home";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    system.url = "github:alex-kumpula/system-config";
    home.url = "github:alex-kumpula/home-config";

    system.inputs.nixpkgs.follows = "nixpkgs";
    system.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    home.inputs.nixpkgs.follows = "nixpkgs";
    home.inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
    home.inputs.home-manager.follows = "home-manager";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, system, home, ... }:
  let
    sharedModule = {
      home.file.".shared.txt".text = ''
        Hello! This file comes from the combined flake.
      '';
    };

    # Rebuild each homeConfiguration by extending its module list
    rebuildHomeConfig = name: origCfg:
      home-manager.lib.homeManagerConfiguration {
        pkgs = origCfg.pkgs;
        extraSpecialArgs = origCfg.extraSpecialArgs or {};
        modules = (origCfg.modules or []) ++ [ sharedModule ];
      };
  in {
    nixosConfigurations = system.nixosConfigurations;

    # Map over all imported homeConfigurations
    homeConfigurations = builtins.mapAttrs rebuildHomeConfig home.homeConfigurations;
  };
}
