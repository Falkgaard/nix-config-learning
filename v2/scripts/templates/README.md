Placeholders within the templates' files and/or file names will be written in upper case and are the following:

* `USER`: a user name (e.g. `jane.doe`).

* `HOST`: a host name (e.g. `work-laptop`).

* `ARCHITECTURE`: a target architecture (e.g. `x86_64-linux`).

These are meant to be substituted when used by the scripts in [`scripts`](..).

[`HOST.host`](HOST.host) is meant to be added to [`/hosts/`](hosts) when a new host is created. **IMPORTANT NOTE:** It's missing a `hardware-configuration.nix` file which needs to be generated on the target host! (This will be done in [`add_host.sh`](scripts/add_host.sh) using `nixos-generate-config --show-hardware-config > ./hosts/HOST.host/hardware-configuration.nix`.)

[`flake.nix.host-snippet`](flake.nix.host-snippet) is meant to be transplanted into a certain place in [`flake.nix`](flake.nix) when a new host is added via [`add_host.sh`](scripts/add_host.sh).

[`USER.user.nix`](USER.user.nix) is meant to be copied into `users`(users) when a new user is added via [`add_user.sh`](scripts/add_user.sh).

[`USER.user-configuration-suite`](USER.user-configuration-suite) is meant to be copied into `home/user-configuration-suites`(home/user-configuration-suites) when a new user is added via [`add_user.sh`](scripts/add_user.sh).

[`flake.nix.configuration-instance-snippet`](flake.nix.configuration-instance-snippet) is meant to be transplanted into a certain place in [`flake.nix`](flake.nix) when a new configuration instance ("user@host") is added via [`add_user_to_host.sh`](scripts/add_user_to_host.sh).

[`HOST@USER.configuration-instance.nix`](HOST@USER.configuration-instance.nix) is meant to be copied into `(config root)/home/user-configuration-suites/USER.user-configuration-suite/user-configuration-instances/USER@HOST.user-configuration-instance.nix` when a new configuration instance (i.e. "user@host") is added via [`add_user_to_host.sh`](scripts/add_user_to_host.sh).

