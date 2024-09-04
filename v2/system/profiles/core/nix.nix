{ inputs, lib, pkgs, ... }:
let
   flakeInputs = lib.filterAttrs  (_: lib.isType "flake")  inputs;
in {
   nix = {
      # package = ...; # TODO

      settings = {
         #extra-substituters = ...; # TODO
         #extra-trusted-public-keys = ...; # TODO

         auto-optimise-store = lib.mkDefault true;

         trusted-users = [
            "root"
            "@wheel"
         ];

         experimental-features = [
            "nix-command"
            "flakes"
            #"ca-derivations"
         ];

         warn-dirty = true;

         system-features = [
            "kvm"
            "nixos-test"
            "big-parallel"
         ];

         flake-registry = ""; # Disable global flake registry.  TODO: Why?
      }; # end-of: `nix.settings`

      gc = {
         automatic  = true;
         frequency  = "weekly";
         options    = "--delete-older-than +3"; # Only keep the 3 most recent generations.
         persistent = true; # TODO: Explain.
      };

      # TODO: Grok this!
      # Add each flake input as a registry and nix_path:
      registry = lib.mapAttrs        (_: flake: {inherit flake;})  flakeInputs;
      nixPath  = lib.mapAttrsToList  (n: _: "${n}=flake:${n}")     flakeInputs;
   };
} # end-of: <module>

