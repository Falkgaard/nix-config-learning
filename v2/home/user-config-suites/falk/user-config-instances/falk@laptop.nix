# falk@laptop user config:
{ pkgs, ... }:
{
    imports = [
       # Required core profile:
       ../profiles/core
       # Desired desktop environment profile(s):
       ../profiles/desktops/hyprland.nix
       ../profiles/desktops/kde-plasma-6.nix
       # Desired workflow profile(s):
       ../profiles/workflows/coding.nix
       ../profiles/workflows/gaming.nix
       ../profiles/workflows/general.nix
       ../profiles/workflows/graphics
       ../profiles/workflows/media.nix
       ../profiles/workflows/personal.nix
    ];
}
