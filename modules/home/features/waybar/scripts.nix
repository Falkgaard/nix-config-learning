# ./modules/home/features/waybar/scripts.nix
{
   pkgs
}:{
   battery = pkgs.writeShellScriptBin "script" ''
      cat /sys/class/power_supply/BAT0/capacity
   '';
} # end-of: <module>

