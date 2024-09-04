# falk@laptop user config:
{ pkgs, ... }:
{
    imports = [
       # Required core profile:
       ./profiles/core.profile
       # Desired desktop environment profile(s):
       ./profiles/desktop.profiles/hyprland.profile.nix
       ./profiles/desktop.profiles/kde-plasma-6.profile.nix
       # Desired workflow profile(s):
       ./profiles/workflow.profiles/coding.profile.nix
       ./profiles/workflow.profiles/gaming.profile.nix
       ./profiles/workflow.profiles/general.profile.nix
       ./profiles/workflow.profiles/graphics.profile.nix
       ./profiles/workflow.profiles/home.profile.nix
       ./profiles/workflow.profiles/media.profile.nix
    ];
}
