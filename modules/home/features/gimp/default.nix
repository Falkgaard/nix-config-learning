# ./modules/home/features/gimp/default.nix
{
   pkgs,
   ...
}:{
   
   home.packages = with pkgs; [
      gimp
   ];
   
   # myHomeManager.impermanence.cache.directories = [
   #    ".config/GIMP"
   # ];
   
} # end-of: <module>

