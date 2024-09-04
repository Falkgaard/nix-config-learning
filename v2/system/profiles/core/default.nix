{ inputs, outputs, ... }: {
   imports = [
      inputs.home-manager.nixosModules.home-manager # TODO: Grok & Explain.
      ./terminal
      ./nix.nix
      ./nix-ld.nix
      ./locale.nix
      ./audio.nix
      ./home.nix
      # TODO: systemd-initrd? sops? auto-upgrade? persistence?
   ] ++ (builtins.attrValues outputs.nixosModules); # TODO: Grok & Explain.

   home-manager.useGlobalPkgs    = true;
   home-manager.extraSpecialArgs = { inherit inputs outputs; }; # TODO: Grok & Explain.

   nixpkgs = {
     #overlays           = builtins.attrValues  outputs.overlays; # TODO: Grok & Explain.
      config.allowUnfree = true;
   };

} # end-of: <module>

# { pkgs, lib, inputs, config, outputs, ... }:
# {
#    imports = [
#       ../system/roles/general-terminal.nix
#    ] ++ (builtins.attrValues outputs.homeManagerModules);
#
#    nix = {
#       package  = lib.mkDefault pkgs.nix;
#       settings = {
#          warn-dirty            = true;
#          experimental-features = [
#             "nix-command"
#             "flakes"
#            #"ca-derivations"
#          ];
#       };
#    };
#
#    programs = {
#       home-manager.enable = true;
#       git.enable          = true;
#    };
#
#    home = {
#       username         = lib.mkDefault "admin";
#       homeDirectory    = lib.mkDefault "/home/${config.home.username}";
#       stateVersion     = lib.mkDefault "24.05";
#       sessionPath      = [ "$HOME/.data" ];
#       sessionVariables = {
#          FLAKE = "$HOME/.config/NixOS";
#       };
#    };
#
#    systemd = {
#       user = {
#          startServices = "sd-switch";
#       };
#    };
# }

