# ./modules/system/features/stylix/default.nix
{
   pkgs,
   inputs,
   ...
}:{
   
   imports = [
      inputs.stylix.nixosModules.stylix
   ];
   
   
   stylix = {
      base16Scheme = {
         base00 = "282828"; # ----
         base01 = "3C3836"; # ---
         base02 = "504945"; # --
         base03 = "665C54"; # -
         base04 = "BDAE93"; # +
         base05 = "D5C4A1"; # ++
         base06 = "EBDBB2"; # +++
         base07 = "FBF1C7"; # ++++
         base08 = "FB4934"; # red
         base09 = "FE8019"; # orange
         base0A = "FABD2F"; # yellow
         base0B = "B8BB26"; # green
         base0C = "8EC07C"; # aqua/cyan
         base0D = "83A598"; # blue
         base0E = "D3869B"; # purple
         base0F = "D65D0E"; # brown
      };
      
      
      # does not work >:(
      # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
      
      
      # TODO: Replace `../../../../` with `${osConfigRoot}` after adding it in `flake.nix`?
      image = ../../../../resourcs/images/sddm/Background.png;
      
      
      fonts = {
         monospace = { # TODO: Use FiraCode instead
            package    = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
            name       = "JetBrainsMono Nerd Font Mono";
         };
         
         sansSerif = {
            package    = pkgs.dejavu_fonts;
            name       = "DejaVu Sans";
         };
         
         serif     = {
            package    = pkgs.dejavu_fonts;
            name       = "DejaVu Serif";
         };
         
         sizes      = {
            applications = 12;
            terminal     = 15;
            desktop      = 10;
            popups       = 10;
         };
      };
      
      
      # TODO: Use Breeze Dark instead
      cursor.name    = "Bibata-Modern-Ice";
      cursor.package = pkgs.bibata-cursors;
      
      
     #targets.chromium.enable           = true;
      targets.grub.enable               = true;
     #targets.grub.useImage             = true;
     #targets.plymouth.enable           = true;
     #stylix.targets.nixos-icons.enable = true;
      
      
      autoEnable = false;
      
   }; # end-of: `stylix`
} # end-of: <module>

