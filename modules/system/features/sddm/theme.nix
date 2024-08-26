# ./modules/system/features/sddm/theme.nix
{
   pkgs
}:{
   pkgs.stdenv.mkDerivation {
      name = "sddm-theme";
      
      src = pkgs.fetchFromGitHub {
         owner  = "MarianArlt";
         repo   = "sddm-sugar-dark";
         rev    = "ceb2c455663429be03ba62d9f898c571650ef7fe";
         sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
      };
      
      # TODO: Use root dir config set in flake.nix (${osConfigRoot} or whatever).
      installPhase = ''
         mkdir -p $out
         cp -R ./* $out/
         cd $out/
         rm Background.jpg
         rm Background.jpeg
         rm Background.png
         cp -r ~/NixOS/resources/images/sddm/* "$out/"
      '';
   }
} # end-of: <module>

