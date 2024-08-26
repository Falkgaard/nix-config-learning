# ./modules/home/bundles/gaming.nix
#
# TODO
{
   pkgs,
   ...
}:{
   
   home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
   };
   
   programs.mangohud.enable = true;
   
   home.packages = with pkgs; [
      lutris
      steam
      steam-run
      protonup-ng
      gamemode
      dxvk
     #parsec-bin
      gamescope
      mangohud
      steamPackages.steam-runtime
      r2modman
      heroic
   ];
   
   #myHomeManager.impermanence.cache.directories = [
   #  ".local/share/Steam"
   #  ".config/r2modmanPlus-local"
   #  "Games"
   #  ".config/heroic"
   #];
} # end-of: <module>

