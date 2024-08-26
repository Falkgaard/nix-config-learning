# ./modules/system/features/power-management/default.nix
{
   ...
}:{
   powerManagement = {
      enable          = true;
      cpuFreqGovernor = "performance";
   };
   
   powerManagement.powertop.enable = true;
   
   services = {
      thermald.enable     = true;
      auto-cpufreq.enable = true;
      upower.enable       = true;
   };
} # end-of: <module>

