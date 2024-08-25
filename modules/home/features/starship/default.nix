{
   pkgs,
   configs,
   ...
}:{
   programs.starship {
      enable = true;

      enableFishIntegration    =  true;   # TODO: make conditional on    Fish being enabled.
      enableZshIntegration     = false;   # TODO: make conditional on     Zsh being enabled.
      enableIonIntegration     = false;   # TODO: make conditional on     Ion being enabled.
      enableBashIntegration    = false;   # TODO: make conditional on    Bash being enabled.
      enableNushellIntegration = false;   # TODO: make conditional on Nushell being enabled.

      settings = {
         
      }; # end of: `programs.starship.settings`
   }; # end of: `programs.starship`
} # end of: <module>

