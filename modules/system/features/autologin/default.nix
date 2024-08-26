# ./modules/system/features/autologin/default.nix
#
# TODO: Describe.
{
   pkgs,
   lib,
   config,
   ...
}: let
   cfg = config.myOS.autologin;
in {
   options.myOS.autologin = {
      user = lib.mkOption {
         default     = null;
         description = ''
            Username to autologin.
         '';
      };
   };
   
   config = lib.mkIf (cfg.user != null) {
      programs.bash.shellInit = ''
         if [ "$(tty)" = "/dev/tty1" ]; then
            exec Hyprland &> /dev/null
         fi
      '';
   };
} # end-of: <module>

