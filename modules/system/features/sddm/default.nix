# ./modules/system/features/sddm/default.nix
#
# TODO: Describe.
{
   pkgs,
   lib,
   ...
}:
let
   sddmTheme = import ./theme.nix { inherit pkgs; };
in {
   services.xserver = {
      enable = true;
      displayManager = {
         sddm.enable = lib.mkDefault true;
         sddm.theme  = "${sddmTheme}";
      };
   };
   
   environment.systemPackages = with pkgs; [
      # TODO: Qt6?
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
   ];
} # end-of: <module>

