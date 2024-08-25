Migrate `~/NixOS/modules/home-manager/bundles/` to `./modules/home/bundles/`

Migrate `~/NixOS/modules/nixos/bundles/` to `./modules/system/bundles/`

Migrate `~/NixOS/modules/nixos/default.nix` to `./modules/system/default.nix`

Migrate `~/NixOS/modules/nixos/features/` to `./modules/system/features/`

Migrate `~/NixOS/hosts/*` to `./hosts/*`

Ensure that path changes are correct (e.g. `myLib -> support-lib`, module paths, feature names, etc).

Ensure that bundle enables are correct.

Add modules:

* mpv

* svp

* krita

* blender

* steam

* heroic

* lutris

* etc...

Properly add qt/gtk/stylix/etc support.

Add Plasma 6 support.

Decide on how to handle graphics drivers.
