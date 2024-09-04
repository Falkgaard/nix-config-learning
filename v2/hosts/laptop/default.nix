{
   imports = [
      # TODO: Refactor into hardware-configuration?
      inputs.hardware.nixosModules.common-cpu-intel
     #inputs.hardware.nixosModules.common-gpu-nvidia # NOTE: No good (because hybrid GPU).
      inputs.hardware.nixosModules.common-pc-ssd

      # ./services # TODO.
      ./hardware-configuration.nix

      # Chosen role:
      ../../system/roles/personal.nix

      # Added user(s):
      ../../users/falk.nix
   ];

   # Configuration for the hybrid GPU hardware:
   hardware.graphics.enable      = true;         # Enables OpenGL (and maybe other things).
   services.xserver.videoDrivers = [ "nvidia" ]; # Load "nvidia" driver for Xorg and Wayland.
   hardware.nvidia               = {
      modesetting.enable            = true;
      nvidiaSettings                = true;
      powerManagement.enable        = false;
      powerManagement.finegrained   = false;
      open                          = false;
      package                       = config.boot.kernelPackages.nvidiaPackages.stable;
      prime                         = {
         nvidiaBusId                   = "PCI:0:1:0";
         intelBusId                    = "PCI:0:0:2";
      };
   };

   boot.loader = {
      systemd-boot = {
         enable             = true;
         configurationLimit =    5;
      };
      efi.canTouchEfiVariables = true;
   };

   networking = {
      hostName = "laptop";
     #useDHCP  = true; # TODO.
   };

   services = {
      # TODO.
   };

   system.stateVersion = "24.05"; # TODO: Move into core.profile?
}
