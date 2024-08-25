# ~/NixOS/modules/home-manager/default.nix
#
# This module is responsible for importing all Home Manager modules (bundles and features).
#
# These are located in `~/NixOS/modules/home-manager/bundles/`
#                  and `~/NixOS/modules/home-manager/features/` respectively.
{
   pkgs,
   system,
   inputs,
   config,
   lib,
   myLib,
   ...
}:
let
   cfg = config.myHomeManager;
   
   # Taking all modules in ./features/ and adding enables to them:
   features =
      myLib.extendModules
         (name: {
            configExtension = config: (lib.mkIf cfg.features.${name}.enable config);
            extraOptions    = {
               myHomeManager.features.${name}.enable = lib.mkEnableOption "Enable ${name} feature.";
            };
         })
      (myLib.filesIn ./features);
   
   # Taking all module bundles in ./bundles/ and adding enables to them:
   bundles =
      myLib.extendModules
      (name: {
         configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
         extraOptions    = {
            myHomeManager.bundles.${name}.enable = lib.mkEnableOption "Enable ${name} module bundle.";
         };
      })
      (myLib.filesIn ./bundles);
   
in {
   imports = [] ++ features ++ bundles;
} # end-of: <module>

