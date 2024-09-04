{ inputs, outputs, ... }:
{
   imports = [
      ./shell.submodule.nix
      ./prompt.submodule.nix
      ./essentials.submodule.nix
   ];
}
