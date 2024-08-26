# ./shell.nix
#
# TODO: Describe. (I think it's to setup prerequisites for a fresh install?)
{
   pkgs ? (import ./nixpkgs.nix) {}
}:{
   default = pkgs.mkShell {
      NIX_CONFIG        = "experimental-features = nix-command flakes";
      nativeBuildInputs = with pkgs; [
         nix
         home-manager
         git
         neovim
      ];
   };
} # end-of: <module>

