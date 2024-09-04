These profiles should be fairly self-explanatory.

`common.nix` should only contain desktop things that are fine regardless of desktop environment(s) used. E.g., "glue" for gtk and qt, stylix, etc. Consequently, any deskop environment profile in this directory should import it.
