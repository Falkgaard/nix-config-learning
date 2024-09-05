# TODO: Refactor out of `workflows`?
{ pkgs, config, ... }:
{
   imports = [];
   
   options = {};
   
   config = {
      programs.gamemode.enable = true; # For performance mode.
      
      programs.steam = {
         enable                       = true; # Install Steam.
         remotePlay.openFirewall      = true; # Open ports in the firewall for Steam Remote Play.
         dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server.
      };
      
      environment.systemPackages = with pkgs; [
         heroic            # Install Heroic launcher.
         lutris            # Install Lutris launcher.
         prismlauncher     # Install Prism Launcher (Minecraft launcher).
         #mumble           # Install voice-chat.
         #teamspeak_client # Install voice-chat.
         protonup-qt       # GUI for installing custom Proton versions like GE_Proton.
         (retroarch.override {
            cores = with libretro; [
               # Add more emulators here (if needed):
               dosbox
            ];
         })
      ];
   };
} # end-of: <module>
