# ~/NixOS/libraries/support/default.nix
#
# Description:
#
#    A simple helper library with the purpose of reducing boiler plate code.
#
{inputs}: let
   support-lib = (import ./default.nix) { inherit inputs; };
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
      inputs.home-manager.lib.homeManagerConfiguration {
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
   
   filesIn = dir: (map (fname: dir + "/${fname}")
      (builtins.attrNames (builtins.readDir dir)));
   
   dirsIn = dir:
      inputs.nixpkgs.lib.filterAttrs (name: value: value == "directory")
      (builtins.readDir dir);
   
    fileNameOf = path: (builtins.head (builtins.split "\\." (baseNameOf path)));
   
   # ========================== Extenders =========================== #
   
   # Evaluates NixOS/modules/home/ module and extends its options / config.
   extendModule = {path, ...} @ args: {pkgs, ...} @ margs: let
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
   in {
      imports =
         (eval.imports or [])
         ++ extra;
      
      options =
         if builtins.hasAttr "optionsExtension" args
         then (args.optionsExtension (eval.options or {}))
         else                        (eval.options or {});
      
      config =
         if builtins.hasAttr "configExtension" args
         then (args.configExtension (eval.config or evalNoImports))
         else                       (eval.config or evalNoImports);
   };
   
   # Applies extendModules to all modules
   # modules can be defined in the same way
   # as regular imports, or taken from "filesIn"
   extendModules = extension: modules:
      map
      (f: let
         name = fileNameOf f;
      in (extendModule ((extension name) // {path = f;})))
      modules;
   
   # ============================ Shell ============================= #
   forAllSystems = pkgs:
      inputs.nixpkgs.lib.genAttrs [
         "x86_64-linux"
         "aarch64-linux"
         "x86_64-darwin"
         "aarch64-darwin"
      ]
      (system: pkgs inputs.nixpkgs.legacyPackages.${system});
} # end-of: <module>

