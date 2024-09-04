# ~/NixOS/libraries/support.nix
# 
# Description:
#    
#    A simple helper library with the purpose of reducing boiler plate code.
#    

{
   inputs
}:
let
   support-lib = (import ./support.nix) { inherit inputs; };
   outputs     = inputs.self.outputs;
in rec {
   # ======================= Package Helpers ======================== #
   
   pkgsFor = sys: inputs.nixpkgs.legacyPackages.${sys};
   
   # ========================== Buildables ========================== #
   
   mkSystem = config:
      inputs.nixpkgs.lib.nixosSystem {
         specialArgs = {
            inherit inputs outputs support-lib;
         };
         modules = [
            config
            outputs.nixosModules.default
         ];
      };
   
   mkHome = sys: config:
      inputs.homeManager.lib.homeManagerConfiguration {
         
         pkgs = pkgsFor sys;
         
         extraSpecialArgs = {
            inherit inputs support-lib outputs;
         };
         
         modules = [
            config
            outputs.homeManagerModules.default
         ];
      };
   
   # =========================== Helpers ============================ #
   
   filesIn    =  dir: (map (filename: dir + "/${filename}") (builtins.attrNames (builtins.readDir dir)));
   dirsIn     =  dir: inputs.nixpkgs.lib.filterAttrs (name: value: value == "directory") (builtins.readDir dir);
   filenameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));
   
   # ========================== Extenders =========================== #
   
   # Evaluates NixOS/modules/home/ module and extends its options / config.
   extendModule = args@{path, ...}: margs@{pkgs, ...}:
   let
      eval =
         if (builtins.isString path) || (builtins.isPath path)
         then import path margs
         else        path margs;
      
      evalNoImports = builtins.removeAttrs eval ["imports" "options"];
      
      extra =
         if (builtins.hasAttr "extraOptions" args) || (builtins.hasAttr "extraConfig" args)
         then [
            ({...}: {
               options = args.extraOptions or {};
               config  = args.extraConfig  or {};
            })
         ]
         else [];
      
      systems = [
         "x86_64-linux"
         "aarch64-linux"
         "x86_64-darwin"
         "aarch64-darwin"
      ];
   in {
      imports = (eval.imports or []) ++ extra;
      
      options =
         if builtins.hasAttr "optionsExtension" args
         then (args.optionsExtension (eval.options or {}))
         else                        (eval.options or {});
      
      config =
         if builtins.hasAttr "configExtension" args
         then (args.configExtension (eval.config or evalNoImports))
         else                       (eval.config or evalNoImports);
   };
   
   # Applies extendModule to all modules.
   # Modules can be defined in the same way as regular imports or taken from "filesIn".
   extendModules = extension: modules:
      map
         (f:
            let
               name = filenameOf f;
            in (
               extendModule ( (extension name) // {path = f;} )
            )
         )
         modules;
   
   # ============================ Shell ============================= #
   forAllSystems = pkgs:
      inputs.nixpkgs.lib.genAttrs
         systems
         (system: pkgs inputs.nixpkgs.legacyPackages.${system});
   
} # end-of: <module>


