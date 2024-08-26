# ./modules/system/features/xremap-user/default.nix
{
   pkgs,
   ...
}:{
   hardware.uinput.enable      = true;
   users.groups.uinput.members = ["falk"];
   users.groups.input.members  = ["falk"];
} # end-of: <module>

