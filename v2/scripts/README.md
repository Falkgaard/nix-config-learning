# [`add_host.sh`](add_host.sh)

## Argument(s)

**1:** the desired host name (referred to as `HOST` below)

## Description

This script creates a new host with the desired host name using a generic file template and snippet. The generated `default.nix` file in `/hosts/HOST.host` will be barebones and will likely need to be further customized for the host.

**Important note:** The script needs to generate the host machine's hardware configuration and must therefore be run on the target machine!


# [`add_user.sh`](add_user.sh)

## Argument(s)

**1:** the desired user name (referred to as `USER` below)

## Description

This script creates a new user with the desired user name using generic file templates and snippets. The generated files in `home/user-configuration-suites/USER` and the file `users/USER.user.nix` will be barebones and will likely need to be further customized for the user.


# [`add_user_to_host.sh`](add_user_to_host.sh)

## Argument(s)

**1:** the user name (referred to as `USER` below)

**2:** the host name (referred to as `HOST` below)

**3:** (optional) the target architecture (defaults to `x86_64-linux`)

## Description

This script creates a configuration instance for the user-host pair using a template file. The generated file `home/user-configuration-suites/USER/user-configuration-instances/USER@HOST.nix` will be barebones and will likely need to be futher customized for the user.


# [`rebuild_host.sh`](rebuild_host.sh)

## Argument(s)

**1:** the host name

## Description

This script will attempt to rebuild the host's NixOS system with the host's configuration.

