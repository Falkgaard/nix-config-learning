# ./modules/home/bundles/desktop-full.nix
{
   pkgs,
   lib,
   ...
}:{
   
   myHomeManager = {
      # Bundles:
      bundles.desktop.enable   = lib.mkDefault true;
      # Features:
      features.gimp.enable     = lib.mkDefault true;
      features.hyprland.enable =               true; # TODO: Find out why not lib.mkDefault
      features.firefox.enable  =               true; # TODO: Find out why not lib.mkDefault
     #features.vesktop.enable  = lib.mkDefault true;
     #features.rbw.enable      = lib.mkDefault true;
     #features.chromium.enable = lib.mkDefault true;
   };
   
   
   home.packages = with pkgs; [
     #youtube-music
     #tdesktop
   ];
   
} # end-of: <module>

