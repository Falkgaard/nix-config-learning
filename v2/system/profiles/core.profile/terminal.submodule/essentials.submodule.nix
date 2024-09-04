{ ... }:
{
   # programs.bat = {
   #   enable       = true;
   #   config.theme = "base16";
   # };
   programs.git.enable    = true;
   programs.tmux.enable   = true;
   programs.neovim.enable = true; # TODO: ./editor.nix
   programs.yazi.enable   = true; # TODO: ./file-manager.nix

   # TODO: ssh, less?
}
