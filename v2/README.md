# General structure

## [`./flake.nix`](flake.nix)

This is the core entry point and serves two primary features:

1. To (re)build NixOS for a specific target host with a single command: (e.g. to rebuild it for my laptop I can do something like `sudo nixos-rebuild switch --flake 'github:Falkgaard/NixOS#laptop`). (Note: A QoL shell script will be provided for this later.)

2. To ensure reproducibility by pinning any dependency version with a `flake.lock` file.

## [`./README.md`](README.md)

This one ought to be self-explanatory. You're reading it now.

## [`./LICENSE`](LICENSE)

This is the chosen license of the repo. 

## [`./nixpkgs.nix`](nixpkgs.nix)

**TODO:** Describe.

## [`./home`](home)

This directory contains user profiles (things like user-installed applications, user configurations, etc); both general as well as user-host specifics.

## [`./hosts`](hosts)

This directory contains host machine configurations.

For example, [`laptop.host`](`./hosts/laptop.host) is the configuration for my personal laptop, which contains the following two files:

[`laptop.host/hardware-configuration.nix`](`./hosts/laptop.host/hardware-configuration.nix) which is the hardware configuration specific to the laptop as well as [`laptop.host/default.nix`](`./hosts/laptop.host/default.nix) which contains some additional configuration specific to it as well as imports the role I want it to fill (in this case, [`./system/roles/personal.role.nix`](system/roles/personal.role.nix)).

## [`./libraries`](libraries)

This directory is meant for configuration libraries (mainly small helper modules with the purpose of reducing boilerplate code.)

## [`./scripts`](scripts)

This directory hasn't been added yet, but it will contain any shell scripts that might be useful. Mainly convenience ones, such as a script for adding a new user (by copying some default template), assigning users to hosts, (re)building a specific host, etc.

## [`./system`](system)

This directory contains system-level configurations in the form of roles and system profiles. Every host should have a single role which should consist of *one or more* system profiles. Generally this should be configurations for things that require root access or affect all users.

### [`./system/profiles`](system/profiles)

This directory contains the system profiles (nix configurations ending in `.profile.nix` or module directories ending in `.profile` and containing a `default.nix` file.

#### [`./system/profiles/core.profile`](./system/profiles/core.profile)

This is the core system profile that represents globally shared essential configuration (i.e. configuration that is meant for all hosts) and should therefore be imported by *all* roles.

#### [`./system/profiles/desktop.profiles`](./system/profiles/desktop.profiles)

This directory contains profiles for things such as boot loaders, desktop managers, display managers, etc. Every role will likely want to pick one of these.

For example, the [`desktop.profiles/kde.profile.nix`](./system/profiles/desktop.profiles/kde.profile.nix) configuration selects SDDM and KDE Plasma 6.

(**TODO:** Consider whether boot loaders should be included here. Also consider whehther WMs/DEs should be handled here or in userland.)

### [`./system/roles`](system/roles)

This directory contains the system roles (nix configurations ending in `.role.nix`) which import one or more profiles from [`./system/profiles`](system/profiles).

For example, the [`personal.role.nix`](system/roles/personal.role.nix) role is meant for personal computers. Later on I'll be adding roles such as `work.role.nix`, `media-pc.role.nix`, and maybe ones such as `build-server.role.nix` or `web-server.role.nix`.

## [`./users`](users)

This is where the system side of users live (whereas the user side is in [`./home`](home)).

For every user `X` there should exist a file `X.user.nix` here that adds and sets up that user when imported by a host `Y` in `./hosts/Y.host/default.nix`.

## TODO

Things to be added: shell, hydra, sops, git specific files, templates, overlays, pkgs, etc.

Decide on a structure for resource directories. I'm currently leaning towards having two locations for them:

The first being `./home/user.profiles/SomeUser/resources` for resources specific to SomeUser (e.g. wallpapers).

And the second being possibly `./system/resources`. In this case I'd probably want it to have a structure like `./system/resources/SomeProfile` and/or `./system/resources/SomeRole`... TODO: Deliberate!

# Making additions

## Adding new hosts

If you want to add a new machine (e.g. server, work PC, media PC, etc), e.g. `work-laptop`, then you should create a new directory in [`./hosts`](hosts) that has its name suffixed with `.host` (e.g. `./host/work-laptop.host`). This directory should contain a `default.nix` file (in which **one** role from [`./system/roles/`](system/roles) should be imported; additional tweaks may be added, but ideally the role should cover most of it; another option is creating a new more fitting role in which case additional system profiles in [`./system/profiles/`](system/profiles) might also be necessary) and a generated `hardware-configuration.nix` file. Also make sure to make the appropriate additions to [`./flake.nix`](flake.nix), namely:

Locate the following attribute set:

```
      # Host system configuration registration:
      nixosConfigurations = {
         ...
      };
````

Inside of it you'll want to add a name-value pair corresponding to the new host system, e.g. for a `work-laptop` host:

```
         # (1) This value should be your host name.
         work-laptop = lib.nixosSystem {
            modules     = [ ./hosts/work-laptop.host ]; # (2) This path should correspond to your host configuration directory.
            specialArgs = { inherit inputs outputs; };
         };
```

## Adding new users

If you want to add a new user (e.g. `guest` or `mom`), first create a corresponding `.user.nix` file in [`./users`](users) (e.g. `./users/mom.user.nix`) that contains the system inclusion (see existing `.user.nix` files for reference) and then create a new profile directory for each in [`./home/user.profiles`] (e.g. `./home/user.profiles/mom`) which should then contain a `user@host.nix` configuration for every host you want the new user to be a part of (e.g. `./home/user.profiles/mom/mom@home-pc.nix`) as well as a `profiles` directory (e.g. `./home/user.profiles/mom/profiles`) that contains any user specifics (user installations and configurations, etc). The purpose of the `user@host.nix` configurations is mainly to enable the features in `profiles` that the user wants for that specific host. For example, you might have a gaming profile that you only want on your personal laptop whereas some more general profile(s) for things like web browsing, text processing, etc might be desired on both home and work computers.

## Adding new users to a host

For a user `X` and a host `Y`, this is as simple as going to `./hosts/Y.host/default.nix` and adding `../../users/X.user.nix` to the `imports = [ ... ]` and then making the following changes to [`./flake.nix`](flake.nix):

Locate the following attribute set:

```
      # Home configuration registration:
      homeConfigurations = {
         ...
      };
````


Inside of it you'll want to add a name-value pair corresponding to the new user-host, e.g. for a `mom@media-pc` combination:

```
         # (1) This value should be your "user@host".
         "mom@media-pc` = lib.homeManagerConfiguration {
            # These paths should end with `/user/user@host.nix` and /user/nixpkgs.nix` respectively (with the user and host names you want).
            modules          = [ "./home/user.profiles/mom/mom@media-pc.nix" "./home/user.profiles/mom/nixpkgs.nix" ];
            pkgs             = pkgsFor.x86_64-linux;
            extraSpecialArgs = { inherit inputs outputs; };
         };
```

(**TODO:** Verify that the module line's usage of strings for paths is valid.)
