# Description

A NixOS configuration that uses a [Nix flake](https://nixos.wiki/wiki/flakes) and [Home Manager](https://nixos.wiki/wiki/Home_Manager) inspired by [Vimjoyer](https://www.youtube.com/@vimjoyer)'s great YouTube videos and example configs as well as [No Boilerplate](https://www.youtube.com/@NoBoilerplate). Still very much a work in progress!

# Structure

`./flake.nix` is the Nix flake that's at the core of the configuration. This file is essentially the entry point that contains various dependencies and core functionality (such as utilizing the support library to generate host system configurations and home configurations).

`./flake.lock` is the associated lock-file that gets generated.

`./nixplgs.nix` (TODO)

`./shell.nix` (TODO)

Then there are the following three directories:

* `./hosts/` which contains the host configurations (e.g. `laptop`, `work`, `media-pc`, etc). Each host is represented by a sub-directory with its name, which in turn contains its configuration files (generally `configuration.nix`, `hardware-configuration.nix`, and `home.nix`).

* `./libraries/` which contains libraries (generally meant to reduce boilerplate code). 

* `./modules/` which contains modules (such as applications) split across a `system/` and `home/` sub-directory.

* `./modules/system/` contains system modules, i.e. ones that are system-wide (global) or at a system level (requiring super user privileges). Think of it kinda like `/`.

* `./modules/system/bundles/` contains system module bundles that group together relevant feature and might expose options. (TODO: provide a good example).

* `./modules/system/features/` contains system feature modules, these are generally stand-alone modules. (E.g. sddm)

* `./modules/home/` contains home modules, i.e. ones that are user-centric and are tied to Home Manager. E.g. user-facing applications and configurations. Think of it kinda like `~/`.

* `./modules/home/bundles/` contains home module bundles that group together relevant feature and might expose options. (E.g. a terminal bundle that encompasses a terminal emulator, shell, prompt, various CLI utilities, etc.)

* `./modules/home/features/` contains home feature modules, these are generally stand-alone modules. (E.g. firefox)

* `./resources` contains resource data such as background images, wallpapers, etc.

* **TODO:** Later on `./modules/home/services/` and `./modules/home/services/` will be added.

Generally, the host configurations will rely on modules for almost all features. This way, modules can easily be re-used by various hosts with their necessary configuration of the features and bundles (when the defaults do not suffice) inside of their respective host configurations.



# Order of config processing:

(TODO: Verify that this is the order!)

1. `./flake.nix`

2. `./hosts/X/configuration.nix`

3. `./hosts/X/hardware-configuration.nix`

4. `./hosts/X/home.nix`

5. `./modules/system/bundles/X.nix` and `./modules/home/bundles.nix`

6. `./modules/system/features/X.nix` and `./modules/home/features/X.nix`
