# ~/NixOS/flake.nix
#
# TODO: Describe.
{
   description = "NixOS config flake";
   
   
   
   inputs = {
      nixpkgs.url                = "github:nixos/nixpkgs/nixos-unstable";
      
      home-manager = {
         url                     = "github:nix-community/home-manager";
         inputs.nixpkgs.follows  = "nixpkgs";
      };
      
      nix-index-database = {
         url                     = "github:Mic92/nix-index-database";
         inputs.nixpkgs.follows  = "nixpkgs";
      };
      
      nix-colors.url             = "github:misterio77/nix-colors";
      
      hyprland.url               = "github:hyprwm/hyprland";
      #hyprland = {
      #   type                    = "git";
      #   url                     = "https://github.com/hyprwm/Hyprland";
      #   submodules              = true;
      #};
      
      hyprland-plugins = {
         url                     = "github:hyprwm/hyprland-plugins";
         inputs.hyprland.follows = "hyprland";
      };
      
      # TODO: Look into what else might be worth adding, e.g:
      #
      #    disko
      #    impermanence
      #    stylix
      #    firefox-addons
      #    nix-alien
      #    ...
   }; # end-of: `inputs`
   
   
   
   outputs = { ... } @inputs:
   let
      # A simple library that reduces boilerplate code.
      myLib  = import ./my-lib/default.nix { inherit inputs; };
      # system = "x86_64-linux";
      # pkgs   = nixpkgs.legacyPackages.${system};
   in
   with myLib; {
      
      nixosConfigurations = {
         laptop = mkSystem ./host/laptop/configuration.nix;
         # NOTE: Add more host system configurations here when needed.
      };
      
      homeConfigurations = {
         "falk@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;
         # NOTE: Add more host home configurations here when needed.
      };
      
      homeManagerModules.default = ./modules/home-manager;
      nixosModules.default       = ./modules/nixos;
   };
   
} # end-of: <module>

# NOTE: Old outputs configuration.
# TODO: Remove when the above is shown to work.
#
#   outputs = { self, nixpkgs, home-manager, hyprland, ... } @inputs:
#   let
#      system = "x86_64-linux";
#      pkgs   = nixpkgs.legacyPackages.${system};
#   in {
#      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
#         specialArgs = { inherit inputs; };
#         modules     = [
#            inputs.home-manager.nixosModules.default
#            #{ wayland.windowManager.hyprland.enable = true; }
#            ./hosts/default/configuration.nix
#         ];
#      };
#   };

