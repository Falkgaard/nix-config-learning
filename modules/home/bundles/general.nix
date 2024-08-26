# ./modules/home/bundles/general.nix
{
   pkgs,
   config,
   lib,
   inputs,
   ...
}:{
    
   nixpkgs = {
      config = {
         allowUnfree           = true;
         experimental-features = "nix-command flakes";
      };
   };
    
    
   myHomeManager.fish.enable       = lib.mkDefault true;
   myHomeManager.git.enable        = lib.mkDefault true;
   myHomeManager.stylix.enable     = lib.mkDefault true;
  #myHomeManager.lf.enable         = lib.mkDefault true;
  #myHomeManager.yazi.enable       = lib.mkDefault true;
  #myHomeManager.nix-extra.enable  = lib.mkDefault true;
  #myHomeManager.btop.enable       = lib.mkDefault true;
  #myHomeManager.nix-direnv.enable = lib.mkDefault true;
  #myHomeManager.nix.enable        = lib.mkDefault true;
  #myHomeManager.bottom.enable     = lib.mkDefault true;
   
   
   programs.home-manager.enable = true;
   programs.bat.enable          = true;
  #programs.lazygit.enable      = true;
   
   
   home.packages = with pkgs; [
      git
      wget
      neovim
      tree-sitter
      neofetch
      ffmpeg
      imagemagick
     #file
     #p7zip
     #unzip
     #zip
     #nil
     #pistol
     #stow
     #libqalculate
     #killall
     #fzf
     #htop
     #lf
     #eza
     #fd
     #zoxide
     #du-dust
     #ripgrep
     #yt-dlp
     #nh
     #nixd
   ];
   
   
   home.sessionVariables = {
      FLAKE = "${config.home.homeDirectory}/nixconf";
   };
   
   
   #myHomeManager.impermanence.data.directories = [
   #   ".ssh"
   #];
   
   
   #myHomeManager.impermanence.cache.directories = [
   #   ".local/share/nvim"
   #   ".config/nvim"
   #];
   
   
   #myHomeManager.impermanence.cache.files = [
   #   ".zsh_history"
   #];
   
} # end-of: <module>

