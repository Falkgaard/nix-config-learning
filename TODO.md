Migrate `~/NixOS/modules/home-manager/bundles/` to `./modules/home/bundles/`

Migrate `~/NixOS/modules/nixos/bundles/` to `./modules/system/bundles/`

Migrate `~/NixOS/modules/nixos/default.nix` to `./modules/system/default.nix`

Migrate `~/NixOS/modules/nixos/features/` to `./modules/system/features/`

Migrate `~/NixOS/hosts/*` to `./hosts/*`

Ensure that path changes are correct (e.g. `myLib -> support-lib`, module paths, feature names, etc).

Ensure that bundle enables are correct.
