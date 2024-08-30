# ./modules/home/bundles/desktop.nix
{
   pkgs,
   config,
   inputs,
   lib,
   ...
}:{
   
   options = {
      myHomeManager.startupScript = lib.mkOption {
         default     = "";
         description = ''
            Startup script
         '';
      };
   };
   
   
   config = {
      
      myHomeManager.features.zathura.enable  = lib.mkDefault true;
      myHomeManager.features.rofi.enable     = lib.mkDefault true;
      myHomeManager.features.kitty.enable    = lib.mkDefault true;
      myHomeManager.features.xremap.enable   = lib.mkDefault true;
      
      
      # myHomeManager.gtk.enable = lib.mkDefault true;
      
      
      home.file = {
         ".local/share/rofi/rofi-bluetooth".source = "${pkgs.rofi-bluetooth}";
      };
      
      
      # TODO:
      #
      # qt.enable        = true;
      # qt.platformTheme = "gtk";
      # qt.style.name    = "adwaita-dark";
      # 
      # home.sessionVariables = {
      #    QT_STYLE_OVERRIDE  = "adwaita-dark";
      # };
      
      
      services.udiskie.enable = true;
      
      
      xdg.mimeApps.defaultApplications = {
         "text/plain"      = ["kate.desktop"];
         "application/pdf" = ["zathura.desktop"];
         "image/*"         = ["imv.desktop"];
         "video/png"       = ["mpv.desktop"];
         "video/jpg"       = ["mpv.desktop"];
         "video/*"         = ["mpv.desktop"];
      };
      
      
      services.mako = {
         enable         = true;
         borderRadius   = 5;
         borderSize     = 2;
         defaultTimeout = 10000;
         layer          = "overlay";
      };
      
      
      home.packages = with pkgs; [
         kitty
         mpv
         svp
         libnotify
         zathura
         upower
         virt-manager
         feh
         polkit
        #polkit_gnome
        #adwaita-qt
        #noisetorch
        #lxsession
        #pulsemixer
        #pavucontrol
        #pcmanfm
        #pywal
        #neovide
        #ripdrag
        #sxiv
        #lm_sensors
        #cm_unicode
        #wezterm
        #onlyoffice-bin
        #easyeffects
        #gegl
      ];
      
      
      myHomeManager.impermanence.cache.directories = [
         ".local/state/wireplumber"
      ];
      
   }; # end-of: `config`
} # end-of: <module>

