{
   description = "Falk's NixOS Config MK.II.";

   nixConfig = {}; # TODO.

   # The inputs the flake depends on:
   inputs = {
      nixpkgs.url  = "github:nixos/nixpkgs/nixos-unstable"; # Using the unstable channel.
      hardware.url = "github:nixos/nixos-hardware";
     #systems.url  = "github:nix-systems/default-linux";
      hyprland.url = "github:hyprwm/hyprland";
      home-manager = {
         url                    = "github:nix-community/home-manager";
         inputs.nixpkgs.follows = "nixpkgs";
      };
      # TODO: impermanence, nix-colors?, sops-nix, nix-gl, etc.
   };
   
   # The generated output configuration:
   outputs = inputs@{ self, nixpkgs, home-manager, systems, ... }:
   let
      # (OLD) support-lib = import ./libraries/support.nix { inherit inputs; };
      # TODO: Grok & Explain (the whole let-in block content).
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      # Helper function(s):
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor       = lib.genAttrs (import systems) (
         system:
            import nixpkgs {
               inherit system;
               config.allowUnfree = true;
            }
      );
   in {
      inherit lib;

      nixosModules       = import ./system/modules;
      homeManagerModules = import ./home/modules;
     #overlays           = import ./overlays  { inherit inputs outputs; }; # TODO.
     #hydraJobs          = import ./hydra.nix { inherit inputs outputs; }; # TODO.

      packages           = forEachSystem (pkgs: import ./pkgs      { inherit pkgs; } );
     #devShells          = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; } ); # TODO.
     #formatter          = forEachSystem (pkgs: pkgs.alejandra );                       # TODO.

      # Host system configuration registration:
      nixosConfigurations = {
         # (OLD) laptop = support-lib.mkSystem ./hosts/laptop;
         laptop = lib.nixosSystem {
            modules     = [ ./hosts/laptop ];
            specialArgs = { inherit inputs outputs; };
         };
         # NOTE: Add more host system configurations here (when needed).
      };
      
      # Home configuration registration:
      homeConfigurations = {
         # (OLD) "falk@laptop" = support-lib.mkHome "x86_64-linux" "./home/user-config-suites/falk/user-config-instance/laptop.nix";
         "falk@laptop" = lib.homeManagerConfiguration {
            modules = [
               ./home/user-config-suites/falk/user-config-instance/laptop.nix
               ./home/user-config-suites/falk/nixpkgs.nix
            ]; # TODO: Verify that strings can be used instead of paths...
            pkgs             = pkgsFor.x86_64-linux;
            extraSpecialArgs = { inherit inputs outputs; };
         };
         # NOTE: Add more home configurations here (when needed).
      };
  };
}

