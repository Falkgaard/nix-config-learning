If you want to add a new machine (e.g. server, work PC, media PC, etc) then you should create a new folder in `./hosts` that has its name. This folder should contain a `default.nix` file and a generated `hardware-configuration.nix` file. Also make sure to make appropriate additions to `./flake.nix`.

If you want to add a new user (e.g. "guest" or "mom"), create a new `.nix` file in `./home/users` that has their username as its name.
