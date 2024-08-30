# ./modules/system/bundles/users.nix
#
# TODO: Describe.
{
   lib,
   config,
   inputs,
   outputs,
   support-lib,
   pkgs,
   ...
}:
let
   cfg = config.myOS;
in {
   
   options.myOS.home-users = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
         options = {
            userConfig = lib.mkOption {
               # TODO: Look into these option values! Redundant left-overs?
               default = ~/NixOS/home-manager/work.nix;
               example = "eDP-1";
            };
            
            userSettings = lib.mkOption {
               default = {};
               example = "{}";
            };
         };
      });
      default = {};
   };
   
   
   
   config = {
      
      # TODO: Set with Terminal bundle in `~/NixOS/hosts/*/home.nix`?
      programs.fish.enable = true;
      
      
      # TODO: Set with Desktop bundle in `~/NixOS/hosts/*/home.nix`?
      programs.hyprland.enable = cfg.hyprland.enable;
      services.xserver         = lib.mkIf cfg.hyprland.enable {
         displayManager = {
            defaultSession = "hyprland";
         };
      };
      
      
      home-manager = {
        useGlobalPkgs    = true;
        useUserPackages  = true;
        extraSpecialArgs = {
           inherit inputs;
           inherit support-lib;
           outputs = inputs.self.outputs;
        };
        
        users = builtins.mapAttrs(
           name : user: {...}: {
              imports = [
                 ( import user.userConfig )
                 outputs.homeManagerModules.default
              ];
           }
        )( config.myOS.home-users );
      };
      
      
      users.users = builtins.mapAttrs(
         name : user: {
            isNormalUser    = true;
            initialPassword = "12345";
            description     = "";
            shell           = pkgs.fish;
            extraGroups     = [ "libvirtd" "networkmanager" "wheel" ];
         }
         // user.userSettings
      )( config.myOS.home-users );
   };
   
} # end-of: <module>

