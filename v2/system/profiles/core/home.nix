{ ... }:
{
   nixpkgs.config.allowUnfree = true;
   
   # # Monitor configuration:
   # monitors = {
   #    # External monitor:
   #    "HDMI-A-1" = {
   #       width       = 2560;
   #       height      = 1440;
   #       refreshRate = 60.0;
   #       x           =    0;
   #       y           =    0;
   #    };
   #    # Laptop monitor:
   #    "eDP-1" = {
   #       # TODO: disable!
   #       width       = 1920;
   #       height      = 1080;
   #       refreshRate = 60.0;
   #       #x          =    0; # TODO
   #       #y          =    0; # TODO
   #    };
   # };
   
   # Home configuration:
   home = {
      stateVersion  = "24.05"; # Do not edit!
      username      = "falk";
      homeDirectory = lib.mkDefault "/home/${home.username}"; # TODO: verify
     #packages      = with pkgs; [];
   };
} # end-of: <module>

