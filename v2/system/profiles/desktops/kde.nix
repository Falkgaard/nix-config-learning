{ pkgs, ... }:
{
   services = {

      displayManager.sddm = {
          extraPackages  = with pkgs; [ sddm-sugar-dark ]; # TODO: Cursor
         #theme          = "sddm-sugar-dark";
          enableHidpi    = true;
          wayland.enable = true;
         #autoLogin      = false; # TODO: Look into.
          settings       = {
             # TODO.
             Theme = {
                Current     = "sddm-sugar-dark";
               #CursorTheme = "TODO";
             };
          };
      };

      desktopManager.plasma6 = {
         enable               = true;
         enableQt5Integration = false;
        #useQtScaling    = true; # NOTE: Only for plasma5!
        #runUsingSystemd = true; # NOTE: Only for plasma5!
      };

   };
}

# GRUB themes:
#    
#    https://www.gnome-look.org/p/1482847
#    https://www.gnome-look.org/p/1009237
#    https://www.gnome-look.org/p/1009236
#    https://www.gnome-look.org/p/1230780
#    https://www.gnome-look.org/p/1420727
#    https://www.gnome-look.org/p/1568741
#    https://www.gnome-look.org/p/1727268
#    https://www.gnome-look.org/p/1968990
#    https://www.gnome-look.org/p/1251112
#    https://www.gnome-look.org/p/1230882
#
#
#
# SDDM themes:
#    
#    https://store.kde.org/s/KDE%20Store/p/1272122
#    https://store.kde.org/s/KDE%20Store/p/2072906
#
#
#
# Plasma splash screen:
#    
#    https://store.kde.org/p/1304256/
#
#
#
# KWin effects:
#    
#    https://github.com/gurrgur/kwin-effects-kinetic
#    https://store.kde.org/s/KDE%20Store/p/2133844
#    https://store.kde.org/s/KDE%20Store/p/2133819
#    https://store.kde.org/s/KDE%20Store/p/2133828
#
#
#
# Cursors:
#    
#    https://store.kde.org/s/KDE%20Store/p/1538515
#    https://store.kde.org/s/KDE%20Store/p/999927
#    https://store.kde.org/s/KDE%20Store/p/999964
#
#
#
# Icons:
#    
#    https://store.kde.org/s/KDE%20Store/p/1516492
