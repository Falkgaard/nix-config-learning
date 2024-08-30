# ./hosts/laptop/configuration.nix
{
   config,
   pkgs,
   lib,
   inputs,
   outputs,
   system,
   support-lib,
   ...
}:{
   
   imports = [
      ./hardware-configuration.nix
      (import ./disko.nix {device = "/dev/nvme1n1";})
      inputs.disko.nixosModules.default
     #"${inputs.nixpkgs-wivrn}/nixos/modules/services/video/wivrn.nix" # NOTE: VR
   ] ++ (myLib.filesIn ./included);
   
   
   boot = {
     #loader.efi.canTouchEfiVariables   = true;
     #loader.systemd-boot.enable        = true;
      systed-boot.configurationLimit    = 5;
      # NOTE: The rest is from Yuri's config... verify it's compatible!
      loader.grub.enable                = true;
      loader.grub.efiSupport            = true;
      loader.grub.efiInstallAsRemovable = true;
      supportedFilesystems              = ["ntfs"];
      kernelParams                      = ["quiet" "udev.log_level=3" "nvidia_drm.fbdev=1" "nvidia_drm.modeset=1"];
      kernelModules                     = ["coretemp" "cpuid" "v4l2loopback"];
   };
   
   
   hardware = {
      enableAllFirmware       = true;
     #cpu.amd.updateMicrocode = true; # NOTE: Needs unfree. (Disabled since Intel CPU).
      #TODO: Add intel? ^
      bluetooth.enable        = true;
      graphics.enable         = true;
      nvidia                  = {
         modesetting.enable      = true;
         open                    = false;
         package                 = config.boot.kernelPackages.nvidiaPackages.stable;
         nvidiaSettings          = true;
         powerManagement         = {
            enable                  = false;
            finegrained             = false;
         };
         prime                   = {
            nvidiaBusId             = "PCI:0:1:0";
            intelBusID              = "PCI:0:0:2";
         };
      };
      opengl = {
         enable          = true;
         driSupport32Bit = true; # TODO: Look into whether this is necessary.
         driSupport      = true; # TODO: Look into whether this is necessary.
      };
   };
   
   
   networking.hostName              = "laptop";
   networking.networkmanager.enable = true;
   networking.firewall.enable       = false;
  #networking.wireless.enable       = true;                                  # Enables wireless support via wpa_supplicant.
  #networking.proxy.default         = "http://user:password@proxy:port/";    # Proxy configuration.
  #networking.proxy.noProxy         = "127.0.0.1,localhost,internal.domain"; # Ditto.
   
   
   services = {
     #hardware.openrgb.enable     = true;
     #flatpak.enable              = true;
     #udisks2.enable              = true;
      printing.enable             = true;
      xserver.videodrivers.enable = true;
   };
   
   
   myOS = {
      bundles.general-desktop.enable   = true;
      bundles.users.enable             = true;
      features.power-management.enable = true;
      features.autologin.user          = "falk";
      features.virtualisation.enable   = lib.mkDefaut true;
     #features.sops.enable             = false;
      features.hyprland.enable         = true;
      
      home-users = {
         "falk"    = {
            userConfig = ./home.nix;
            userSettings = {
               extraGroups = ["networkmanager" "wheel" "libvirtd" "docker" "adbusers" "openrazer"];
            };
         };
      };
      
     #impermanence.enable          = true;
     #impermanence.nukeRoot.enable = true;
   }; # end-of: `myOS`
   
   
   users.users = {
     falk = {
        hashedPasswordFile = "/persist/passwd";
        # TODO: continue here...
     };
   };
   
   
   #[yuri] programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
   
   
   security.polkit.enable = true;
   
   
  #virtualisation.libvirtd.enable = true;
  #virtualisation.podman          = {
  #  enable                          = true;
  #  dockerCompat                    = true;
  #  defaultNetwork.settings         = {
  #    dns_enabled                      = true;
  #  };
  #};
   
   
   programs.hyprland.enable   = true; # TODO: Should this be set inside the feature?
  #programs.alvr.enable       = true; # NOTE: VR
  #programs.alvr.openFirewall = true; # NOTE: VR
  #programs.dconf.enable      = true; # NOTE: Gnome configuration
   
   
  # services.monado.enable              = true;
  # services.monado.highPriority        = true;
  # services.monado.defaultRuntime      = true;
  # services.avahi.enable               = true;
  # services.avahi.publish.userServices = true;
   
   
   # NOTE: This is for VR. Disabled.
   #
   # services.wivrn = {
   #    package =
   #       (import inputs.nixpkgs-wivrn {
   #          system = "${pkgs.system}";
   #          config = {allowUnfree = true;};
   #       })
   #       .wivrn;
   #   #package        = inputs.nixpkgs-wivrn.legacyPackages.${pkgs.system}.wivrn;
   #    enable         = true;
   #    openFirewall   = true;
   #    defaultRuntime = true;
   #    highPriority   = true;
   # };
   
   
   environment.systemPackages = with pkgs; [
      wineWowPackages.stable
      wineWowPackages.waylandFull
      winetricks (pkgs.writeTextFile {
         name        = "configure-gtk";
         destination = "/bin/configure-gtk";
         executable  = true;
         text        = let
            schema      = pkgs.gsettings-desktop-schemas;
            datadir     = "${schema}/share/gsettings-schemas/${schema.name}";
         in ''
            gnome_schema=org.gnome.desktop.interface
            gsettings set $gnome_schema gtk-theme 'Dracula'
         '';
      })
      glib
     #inputs.nixpkgs-wivrn.legacyPackages.${pkgs.system}.wivrn
   ];
   
   
   system.stateVersion      = "24.05"; # Do not edit.
   system.activationScripts = {
      myCustomConfigFile       = ''
         # TODO
      '';
   };
   
   
   xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
   xdg.portal.enable       = true;
   
} # end-of: <module>

