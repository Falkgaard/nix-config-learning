# ./flake.nix
#
# Using Nix flakes let's us make our configuration reproducable since the
# versions of any dependencies will get pinned to a generated `flake.lock` file.
{
   description = "NixOS config flake";
   
   
   
   inputs = {
      # NixOS Unstable channel:
      nixpkgs.url                = "github:nixos/nixpkgs/nixos-unstable";

      # Home Manager:
      home-manager = {
         url                     = "github:nix-community/home-manager";
         inputs.nixpkgs.follows  = "nixpkgs";
      };

      # Nix Index DB:
      nix-index-database = {
         url                     = "github:Mic92/nix-index-database";
         inputs.nixpkgs.follows  = "nixpkgs";
      };

      # Nix Colors:
      nix-colors.url             = "github:misterio77/nix-colors";

      # Hyprland:
      hyprland.url               = "github:hyprwm/hyprland";
      # hyprland = {
      #    type                    = "git";
      #    url                     = "https://github.com/hyprwm/Hyprland";
      #    submodules              = true;
      # };

      # Hyprland Plugins:
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
   
   
   
   outputs = { ... } @inputs:   # OLD: { self, nixpkgs, home-manager, hyprland, ... } @inputs:
   let
      # Import the support library (to reduce boilerplate):
      support-lib = import ./libraries/support/default.nix { inherit inputs; };
      # system = "x86_64-linux";
      # pkgs   = nixpkgs.legacyPackages.${system};
   in
   with support-lib; {
      
      nixosConfigurations = {
         laptop = mkSystem ./hosts/laptop/configuration.nix;
         # NOTE: Add more host system configurations here when needed.
      };
      
      homeConfigurations = {
         "falk@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;
         # NOTE: Add more host home configurations here when needed.
      };
      
      homeManagerModules.default = ./modules/home/;
      nixosModules.default       = ./modules/system/;
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
