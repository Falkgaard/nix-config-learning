{
   services = {

      displayManager.sddm = {
          extraPackages  = with pkgs; [ sddm-sugar-dark ]; # TODO: Cursor
         #theme          = "sddm-sugar-dark";
          enableHidpi    = true;
          wayland.enable = true;
          autoLogin      = false; # TODO: Look into.
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
