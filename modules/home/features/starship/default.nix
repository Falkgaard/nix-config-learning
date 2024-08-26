# ./modules/home/features/starship/default.nix
{
   pkgs,
   configs,
   ...
}:{
   programs.starship {
      enable                = true;
      enableFishIntegration = true;
      settings              = {
         # TODO
      }; # end of: `programs.starship.settings`
   }; # end of: `programs.starship`
} # end of: <module>

