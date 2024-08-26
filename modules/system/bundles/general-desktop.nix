# ./modules/system/bundles/general-desktop.nix
#
# Shared general desktop configurations.
{
   pkgs,
   lib,
   ...
}:{
   
   # Create `myOS` config (will be used elsewhere):
   myOS.sddm.enable              = lib.mkDefault  true;
   myOS.autologin.enable         = lib.mkDefault  true;
   myOS.stylix.enable            = lib.mkDefault  true;
  #myOS.xremap-user.enable       = lib.mkDefault false; # TODO
  #myOS.system-controller.enable = lib.mkDefault false; # TODO
   myOS.virtualisation.enable    = lib.mkDefault false;
   
   
   
   # Locale:
   time.timeZone            = "Europe/Malta";
   i18n.defaultLocale       = "en_GB.UTF-8";
   i18n.extraLocaleSettings = {
      LC_ADDRESS               = "en_GB.UTF-8";
      LC_IDENTIFICATION        = "en_GB.UTF-8";
      LC_MEASUREMENT           = "en_GB.UTF-8";
      LC_MONETARY              = "en_GB.UTF-8";
      LC_NAME                  = "en_GB.UTF-8";
      LC_NUMERIC               = "en_GB.UTF-8";
      LC_PAPER                 = "en_GB.UTF-8";
      LC_TELEPHONE             = "en_GB.UTF-8";
      LC_TIME                  = "en_GB.UTF-8";
   };
   
   
   
   # TODO: Figure out which of these are necessary and which .nix-file(s) to integrate them into:
   #
   #   # Bootloader.
   #   boot.loader.systemd-boot.enable      = true;
   #   boot.loader.efi.canTouchEfiVariables = true;
   #   
   #   networking.hostName        = "nixos"; # Define your hostname.
   #   #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   #   
   #   # Configure network proxy if necessary
   #   # networking.proxy.default = "http://user:password@proxy:port/";
   #   # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
   #   
   #   # Enable networking
   #   networking.networkmanager.enable = true;
   #   
   #   nix.settings.experimental-features = [
   #     "nix-command"
   #     "flakes"
   #   ];
   #   
   #   # Enable the X11 windowing system.
   #   # services.xserver.enable = true;
   #   services.displayManager.sddm.wayland.enable = true;
   #   
   #   # Enable Hyprland:
   #   programs.hyprland.enable          = true;
   #   programs.hyprland.xwayland.enable = true;
   #   programs.hyprland.package         = inputs.hyprland.packages."${pkgs.system}".hyprland;
   #   # disabled (temp): environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
   #   # disabled (temp): environment.sessionVariables.NIXOS_OZONE_WL          = "1";
   #   
   #   # Enable the KDE Plasma Desktop Environment.
   #   services.displayManager.sddm.enable    = true;
   #   services.desktopManager.plasma6.enable = true;
   #   # Disable certain packages:
   #   environment.plasma6.excludePackages = with pkgs.kdePackages; [
   #     # kate
   #     konsole
   #   ];
   #   
   #   # Config Intel/Nvidia hybrid hardware:
   #   hardware.graphics.enable      = true; # Enables OpenGL (and maybe other things)
   #   services.xserver.videoDrivers = [ "nvidia" ]; # Load "nvidia" driver for Xorg and Wayland
   #   hardware.nvidia = {
   #     modesetting.enable          = true;
   #     nvidiaSettings              = true;
   #     powerManagement.enable      = false;
   #     powerManagement.finegrained = false;
   #     open                        = false;
   #     package                     = config.boot.kernelPackages.nvidiaPackages.stable;
   #     prime                       = {
   #       nvidiaBusId = "PCI:0:1:0";
   #       intelBusId  = "PCI:0:0:2";
   #     };
   #   };
   #   
   #   # GTK/Qt themes: (TODO: move into home.nix?)
   #   # disable(temp): qt.enable        = true;
   #   # disable(temp): qt.platformTheme = "gtk2";
   #   # disable(temp): qt.style         = "gtk2";
   #   
   #   # Configure keymap in X11
   #   services.xserver.xkb = {
   #     layout  = "se";
   #     variant = "";
   #   };
   #   
   #   # Configure console keymap
   #   console.keyMap = "sv-latin1";
   #   
   #   # Enable automatic login for the user:
   #   services.displayManager.autoLogin.enable = false;
   #   services.displayManager.autoLogin.user   = "falk";
   #   
   #   # Install firefox:
   #   programs.firefox.enable  = true;
   #   programs.firefox.package = pkgs.firefox.overrideAttrs(
   #      oldAttrs: {
   #         buildCommand = oldAttrs.buildCommand +
   #         ''
   #            wrapProgram $out/bin/firefox  \
   #               --set MOZ_ENABLE_WAYLAND 1 \
   #               --set MOZ_USE_XINPUT2    1
   #         '';
   #      }
   #   );
   #   
   #   # Install NeoVim and make it the default editor:
   #   programs.neovim.enable        = true;
   #   programs.neovim.defaultEditor = true;
   #   
   #   # Enable fish shell:
   #   programs.fish.enable = true;
   #   
   #   # Allow unfree packages
   #   nixpkgs.config.allowUnfree = true;
   #   
   #   # List packages installed in system profile:
   #   environment.systemPackages = with pkgs; [
   #     rofi-wayland # alternatively bemenu|fuzzel|tofi|wofi
   #     swww         # Wallpaper daemon for Hyprland; alternatively hyprpaper|swaybg|wpaperd|mpvpaper
   #     mako         # Notification daemon for Hyprland; alternatively dunst
   #     libnotify    # dependency of mako|dunst
   #     waybar       # Bar for Hyprland
   #     (waybar.overrideAttrs (
   #       oldAttrs: {
   #         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
   #       }
   #     ))
   #     
   #     networkmanagerapplet
   #     grim  # Screenshot utility
   #     slurp # Select utility
   #     wl-clipboard # Wayland alternative to xclip; alternatively wl-copy
   #     
   #     git
   #     kitty
   #     wget
   #     lshw
   #   ];
   #   
   #   # Desktop portal for Hyprland:
   #   xdg.portal.enable = true;
   #   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ]; # TODO: KDE variant?
   #   
   #   # Define a user account. Don't forget to set a password with ‘passwd’.
   #   users.users.falk = {
   #     isNormalUser = true;
   #     shell        = pkgs.fish;
   #     description  = "Falkgaard";
   #     extraGroups  = [ "networkmanager" "wheel" ];
   #     # packages     = with pkgs; [
   #     #   # empty (for now)
   #     # ];
   #   };
   #   
   #   # Home-Manager:
   #   home-manager = {
   #     backupFileExtension = "hm-backup";
   #     extraSpecialArgs    = { inherit inputs; };
   #     users               = {
   #       "falk" = import ./home.nix;
   #     };
   
   
   
   # Enable printing (with CUPS):
   services.printing.enable = true;
   
   # Configure audio:
   hardware.pulseaudio.enable = false; # TODO: Look into.
   sound.enable               = true;
   security.rtkit.enable      = true;
   services.pipewire          = {
      enable                     = true;
      alsa.enable                = true;
      alsa.support32Bit          = true;
      pulse.enable               = true;
      jack.enable                = true;
   };
   
   # Configure fonts:
   fonts.fontconfig.enable = true;
   fonts.packages          = with pkgs; [
      (
         pkgs.nerdfonts.override {
            fonts = [ "JetBrainsMono" "Iosevka" "FiraCode" "IBMPlexMono" ];
         }
      )
      cm_unicode
      corefonts
      noto-fonts
      noto-fonts-emoji
      fira-code-symbols
   ];
   # fonts.enableDefaultPackages = true;
   # fonts.fontconfig            = {
   #   defaultFonts                 = {
   #     monospace                     = ["JetBrainsMono Nerd Font Mono"];
   #     sansSerif                     = ["JetBrainsMono Nerd Font"];
   #     serif                         = ["JetBrainsMono Nerd Font"];
   #   };
   # };
   
   # Configure battery:
   services.upower.enable = true;
} # end-of: <module>

