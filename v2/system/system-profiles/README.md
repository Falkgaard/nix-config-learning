`${CONFIG_ROOT}/system/profiles/core` should *always* be used, since it represents the minimal subset that is the globally shared core profile. Care should be used when adding or removing functionality to this profile.

With certain extreme cases being exceptions, *almost* every role will want *at least* one of the profiles available in ``${CONFIG_ROOT}/system/profiles/desktop-environments` since otherwise their users will be doomed to minimal lives in some terminal.

Most roles will also want to use one or more of the profiles available in `${CONFIG_ROOT}/system/profiles/workflows` (TODO: find a better name?). See `${CONFIG_ROOT}/system/profiles/workflows/README.md` for further info.
