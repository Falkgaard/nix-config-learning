# ./modules/system/bundles/home-manager.nix
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
   
   options.myOS = {
      userName = lib.mkOption {
         default     = "falk";
         description = ''Username'';
      };
      
      
      userConfig = lib.mkOption {
         # TODO: Look into these option values! Redundant left-overs?
         default     = ~/NixOS/home-manager/work.nix;
         description = ''
            home-manager config path
         '';
      };
      
      
      userNixosSettings = lib.mkOption {
         default     = {};
         description = ''
            NixOS user settings
         '';
      };
   };
   
   
   
   config = {
      
      # TODO: Set with Terminal bundle in `./hosts/*/home.nix`?
      programs.zsh.enable  = false;
      programs.fish.enable =  true;
      
      
      # TODO: Set with Desktop bundle in `./hosts/*/home.nix`?
      programs.hyprland.enable = cfg.hyprland.enable;
      services.xserver         = lib.mkIf cfg.hyprland.enable {
         displayManager = {
            defaultSession = "hyprland"; 
         };
      };
      
      
      home-manager = {
         useGlobalPkgs   = true;
         useUserPackages = true;
         
         extraSpecialArgs = {
            inherit inputs;
            inherit support-lib;
            outputs = inputs.self.outputs;
         };
         
         users = {
            ${cfg.userName} = {...}: {
               imports = [
                  (import cfg.userConfig)
                  outputs.homeManagerModules.default
               ];
            };
         };
      };
      
      
      users.users.${cfg.userName} = {
         isNormalUser    = true;
         initialPassword = "12345";
         description     = cfg.userName;
         shell           = pkgs.fish;
         extraGroups     = [ "libvirtd" "networkmanager" "wheel" ];
      }
      // cfg.userNixosSettings;
   };
   
} # end-of: <module>

