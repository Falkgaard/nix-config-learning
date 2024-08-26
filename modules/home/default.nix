# ./modules/home/default.nix
#
# This module is responsible for importing all Home Manager modules (bundles and features).
#
# These are located in `./modules/home/bundles/`
#                  and `./modules/home/features/` respectively.
{
   pkgs,
   system,
   inputs,
   config,
   lib,
   support-lib,
   ...
}:
let
   cfg = config.myHomeManager;
   
   
   # Taking all modules in `./features/` and adding enables to them:
   features =
      support-lib.extendModules
         (name: {
            configExtension = config: (lib.mkIf cfg.features.${name}.enable config);
            extraOptions    = {
               myHomeManager.features.${name}.enable = lib.mkEnableOption "Enable ${name} feature.";
            };
         })
      (support-lib.filesIn ./features);
   
   
   # Taking all module bundles in `./bundles/` and adding enables to them:
   bundles =
      support-lib.extendModules
      (name: {
         configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
         extraOptions    = {
            myHomeManager.bundles.${name}.enable = lib.mkEnableOption "Enable ${name} module bundle.";
         };
      })
      (support-lib.filesIn ./bundles);
   
   
in {
   imports = [] ++ features ++ bundles;
} # end-of: <module>

