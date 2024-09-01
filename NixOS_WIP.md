# Example host configuration (WIP pseudo-code):

# Enable DM, DEs, app bundles, etc:
gui = {
	enable                  = true;
	de.hyprland.enable      = true;
	de.kde-plasma-6.enable  = true;
	bundles.graphics.enable = true;
	bundles.gaming.enable   = true;
	bundles.coding.enable   = true;
};

# Enable preferred shell(s), prompt(s), editor, general tools, TUI file manager, etc:
tui.enable = true; 




# TODO: Decide on where to draw the line between "system" and "home".
#       Bootloader should be system, right?
#       What about DMs and DEs?
#       What about things like git, coreutils, etc?
#
# Things to add
#    
#    pipewire
#    prism?
#    stylix
#    
#    (system?)
#        autologin
#        power-management?
#        virtualization?
#        persistence?
#        xremap(-user)?



system/gui/
system/tui/
system/service/
system/other/ # ?

home/tui/
home/gui/
home/service/
home/other/ # ?




# This module bundle should only contain *pure* GUI content!
# E.g. DE bundles, GUI applications, etc.
gui/default.nix
	...






# TODO: Only do Hyprland to begin with?

# TODO 
gui/de/default.nix:
	...

# TODO: Common things like fonts. What about GTK/QT glue?
gui/de/common.nix:

# While Hyprland is technically not a DE, this bundle's role is to provide
# sufficient configuration for it to be on par with one. 
gui/de/hyprland/default.nix:
	gtk-glue   # submodule bundle (TODO: breeze-gtk + config, etc)
	qt-glue    # submodule bundle (TODO: breeze + config, etc)
	status-bar # submodule bundle (TODO: waybar)
	wallpaper  # submodule bundle (TODO: ewww?)
	runner     # submodule bundle (TODO: rofi?)
	...

# TODO
gui/de/kde-plasma-6/default.nix:
	...

# This submodule bundle should provide the preferred display manager(s).
# This way, any changes in preference will propagate to all hosts.
# (As long as they use the defaults, of course.)
gui/dm/default.nix:
	sddm # submodule (chosen default)
	...



# TODO
gui/bundles/...

# This submodule bundle should contain GUI features that are useful for *all* hosts.
# This way, any changes in preference will propagate to all hosts.
# (As long as they use the defaults, of course.)
gui/bundles/general/default.nix:
	terminal-emulator # submodule bundle (TODO: kitty)
	web-browser       # submodule bundle (TODO: firefox)
	doc-viewer        # submodule bundle (TODO: zathura? ocular?)
	media-player      # submodule bundle (TODO: mpv + svp)
	...

# This submodule bundle should provide a desired set of graphics tools.
gui/bundles/graphics/default.nix
	gimp
	krita
	blender
	...

# This submodule bundle should provide gaming-related features,
# i.e. launchers, emulators, etc.
gui/bundles/gaming/default.nix
	wine   # ?
	proton # ?
	dxvk   # ?
	steam
	heroic
	lutris
	...

# TODO: This is *VERY* WIP!
#
# Some issues to work out:
#    1.  The TUI/GUI split
#    2a. Use Overlays for each?
#    2b. Separate out a list of desired "languages" to enable?
#
gui/bundles/coding/default.nix
	code-oss   # TODO: split into submodule bundle like nvim in tui?

	dev/c      # TODO: WIP
	dev/cpp    # TODO: WIP
	dev/c3     # TODO: WIP
	dev/rust   # TODO: WIP
	dev/luajit # TODO: WIP
	dev/glsl   # TODO: WIP

	# TODO: decide how to handle wasm/emscripten/vulkan/opengl/etc
	...











# This module bundle should only contain *pure* terminal content!
# Certain things that depend on a DE should be provided by the DE bundle 
# in the form of an overlay. (E.g. terminal emulator, image displaying, etc.)
# This way, any changes in preference will propagate to all hosts.
# (As long as they use the defaults, of course.)
tui/default.nix:
	shell         # submodule bundle
	prompt        # submodule bundle
	editor        # submodule bundle
	general       # submodule bundle
	file-manager  # submodule bundle

# This submodule bundle should provide the preferred terminal shell(s).
# This way, any changes in preference will propagate to all hosts.
# (As long as they use the defaults, of course.)
tui/shell/default.nix:
	fish # submodule (chosen default)
	bash # submodule
	...

# This submodule bundle should provide the preferred terminal prompt(s).
# This way, any changes in preference will propagate to all hosts.
# (As long as they use the defaults, of course.)
tui/prompt/default.nix:
	starship # submodule (chosen default)
	...

# This submodule bundle should provide the preferred terminal editor(s).
# This way, any changes in preference will propagate to all hosts.
# (As long as they use the defaults, of course.)
tui/editor/default.nix:
	nvim # submodule (chosen default)
	...

# This submodule bundle should provide the preferred terminal file manager(s).
# This way, any changes in preference will propagate to all hosts.
# (As long as they use the defaults, of course.)
tui/file-manager/default.nix:
	yazi # submodule (chosen default)
	...

# This submodule bundle should contain TUI features that are useful for *all* hosts.
# This way, any changes in preference will propagate to all hosts.
# (As long as they use the defaults, of course.)
tui/general/default.nix:
	coreutils # uutils ?
	git
	wget
	curl
	ssh # ?

	bat
	tree
	tldr

	tmux
	...
	