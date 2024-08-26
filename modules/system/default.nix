# ./modules/system/default.nix
#
# This module is responsible for importing all NixOS modules (bundles, features, and services).
#
# These are located in `~/NixOS/modules/system/bundles/`
#                  and `~/NixOS/modules/system/features/`
#                  and `~/NixOS/modules/system/services/` respectively.
{
   pkgs,
   inputs,
   config,
   lib,
   support-lib,
   outputs,
   ...
}:
let
   cfg = config.myOS;
   
   # Taking all modules in ./features/ and adding enables to them:
   features =
      support-lib.extendModules
         (name: {
            configExtension = config: (lib.mkIf cfg.features.${name}.enable config);
            extraOptions    = {
               myOS.features.${name}.enable = lib.mkEnableOption "Enable ${name} feature.";
            };
         })
      (support-lib.filesIn ./features);
   
   # Taking all module bundles in ./bundles/ and adding enables to them:
   bundles =
      support-lib.extendModules
      (name: {
         configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
         extraOptions    = {
            myOS.bundles.${name}.enable = lib.mkEnableOption "Enable ${name} module bundle.";
         };
      })
      (support-lib.filesIn ./bundles);
   
   # Taking all services in ./services/ and adding enables to them:
   services =
      support-lib.extendModules
      (name: {
         configExtension = config: (lib.mkIf cfg.services.${name}.enable config);
         extraOptions    = {
            myOS.services.${name}.enable = lib.mkEnableOption "Enable ${name} service.";
         };
      })
      (support-lib.filesIn ./services);
   
in {
   imports = [] ++ features ++ bundles ++ services;
   
   options.myOS = {
      hyprland.enable = lib.mkEnableOption "Enable Hyprland."; # NOTE: Should this be here?
   };
   
   config = {
      programs.nix-ld.enable             = true;
      nixpkgs.config.allowUnfree         = true;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
   };
} # end-of: <module>

