# ./modules/system/features/virtualization/default.nix
{
   config,
   lib,
   ...
}: let
   cfg = config.myOS;
in {
   options.myOS = {
      altIsSuper = lib.mkEnableOption "Switch <Super> to <Alt>";
   };
   
   config = {
      virtualisation.vmVariant = {
         myOS.altIsSuper      = true;
         services.sshd.enable = true;
         virtualisation = {
            memorySize     = 4096;
            cores          = 4;
            qemu.options   = [
               "-device virtio-vga-gl"
               "-display sdl,gl=on,show-cursor=off"
               "-audio pa,model=hda"
            ];
            sharedDirectories = {
               primary = {
                  source = "/mnt/shared";
                  target = "/mnt/shared";
               };
            };
         };
      };
   };
} # end-of: <module>

