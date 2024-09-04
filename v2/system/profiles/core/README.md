The core profile should represent the minimum host-agnostic shared configuration.
I.e., things like a shell, a prompt, git, etc.

`${CFG_ROOT}/system/profiles/core/default.nix` is the core entry point.

For cleanliness, parts may be separated into submodules (e.g. all core terminal configuration in `${CFG_ROOT}/system/profiles/core/terminal`) which should be imported by the `default.nix` file.
