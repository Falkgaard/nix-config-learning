# ./modules/home/features/hyprland/default.nix
{
  pkgs,
  config,
  lib,
  inputs,
  osConfig,
  ...
}:
let
   
   moveToMonitor = lib.mapAttrsToList(
      id: workspace: "hyprctl dispatch moveworkspacetomonitor ${id} ${toString workspace.monitorId}"
   ) config.myHomeManager.workspaces;
   
   
   moveToMonitorScript = pkgs.writeShellScriptBin "script" ''
      ${lib.concatLines moveToMonitor}
   '';
   
   
   generalStartScript = pkgs.writeShellScriptBin "start" ''
      ${pkgs.swww}/bin/swww init &
      
      ${pkgs.waybar}/bin/waybar &
      
      ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &
      
      # hyprctl setcursor Bibata-Modern-Ice 16 &
      
      systemctl --user import-environment PATH &
      systemctl --user restart xdg-desktop-portal.service &
      
      # Wait a tiny bit for wallpaper:
      sleep 2
      
      ${pkgs.swww}/bin/swww img ${config.stylix.image} &
      
      # Wait for monitors to connect:
      sleep 3
      ags &
      
      ${lib.getExe moveToMonitorScript}
      
      # General startupScript extension:
      ${config.myHomeManager.startupScript}
    '';
   
   
   autostarts = lib.lists.flatten(
      lib.mapAttrsToList(
         id: workspace: (map (startentry: "[workspace ${id} silent] ${startentry}") workspace.autostart)
      )
      config.myHomeManager.workspaces
   );
   
   
   monitorScript = pkgs.writeShellScriptBin "script" ''
      handle() {
         case $1 in monitoradded*)
            ${lib.getExe moveToMonitorScript}
         esac
      }
      ${lib.getExe pkgs.socat} - "UNIX-CONNECT:/tmp/hypr/''${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
   '';
   
   
   exec-once = [
      ( lib.getExe   generalStartScript )
      ( lib.getExe        monitorScript )
      # NOTE(yurii): I forgot why I need this
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ] ++ autostarts;
   
in {
   
   imports = [
      ./monitors.nix
      ./keymaps.nix
   ];
   
   
   options = {
      hyprlandExtra = lib.mkOption {
         default     = "";
         description = ''
            extra hyprland config lines
         '';
      };
   };
   
   
   config = {
      
      myHomeManager.waybar.enable = lib.mkDefault false;
      myHomeManager.ags.enable    = lib.mkDefault  true;
      myHomeManager.keymap.enable = lib.mkDefault  true;
      
      wayland.windowManager.hyprland = {
         
         # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
         
         enable = true;
         
         
         settings = {
            general = {
               gaps_in               =  5;
               gaps_out              = 10;
               border_size           =  2;
               "col.active_border"   = "rgba(33CCFFEE) rgba(00FF99EE) 45deg";
               "col.inactive_border" = "rgba(595959AA)";
              #"col.active_border"   = lib.mkForce "rgba(${config.stylix.base16Scheme.base0E}FF) rgba(${config.stylix.base16Scheme.base09}FF) 60deg";
              #"col.inactive_border" = lib.mkForce "rgba(${config.stylix.base16Scheme.base00}FF)";
               resize_on_border      = false;
               allow_tearing         = false; # See https://wiki.hyprland.org/Configuring/Tearing/ before enabling.
               #layout               = "dwindle";
            };
            
            
            monitor = lib.mapAttrsToList(
               name: m: let
                  resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
                  position = "${toString m.x}x${toString m.y}";
               in "${name}, ${
                  if m.enabled
                  then "${resolution}, ${position}, 1"
                  else "disable"
               }"
            )( config.myHomeManager.monitors );
            
            
            # workspace =
            #   lib.mapAttrsToList
            #   (
            #     name: m: "${m.name},${m.workspace}"
            #   )
            #   (lib.filter (m: m.enabled && m.workspace != null) config.myHomeManager.monitors);
            
            
            env = [
               "XCURSOR_SIZE,24"
              #"xcursor_size,24"
              #"hyprcursor_size,24"
            ];
            
            
            input = {
               kb_layout      = "us,ru,ua";
               kb_variant     = "";
               kb_model       = "";
               kb_options     = "grp:alt_shift_toggle,caps:escape";
               kb_rules       = "";
               follow_mouse   = 1;
               touchpad       = { natural_scroll = false; };
               repeat_rate    = 40;
               repeat_delay   = 250;
               force_no_accel = true;
               sensitivity    = 0.0; # -1.0 - 1.0, 0 means no modification.
            };
            
            
            misc = {
               enable_swallow          = true;
               force_default_wallpaper = 0;
              #swallow_regex           = "^(Alacritty|wezterm)$";
            };
            
            
            binds = {
               movefocus_cycles_fullscreen = 0; # TODO: look into.
            };
            
            
            decoration = {
               rounding            = 5;
               active_opacity      = 1.0;
               inactive_opacity    = 0.975;
               drop_shadow         = true;
               shadow_range        = 20;
               shadow_render_power = 3;
               "col.shadow"        = "rgba(1A1A1AEE)";
               blur                = {
                   enabled            = true;
                   size               = 3;
                   passes             = 1;
                   vibrancy           = 0.1696;
               };
            };
            
            
            # TODO!
            animations = {
               enabled = true;
              #bezier = myBezier, 0.05, 0.9, 0.1, 1.05
              #animation = [
              #   "windows, 1, 7, myBezier"
              #   "windowsOut, 1, 7, default, popin 80%"
              #   "border, 1, 10, default"
              #   "borderangle, 1, 8, default"
              #   "fade, 1, 7, default"
              #   "workspaces, 1, 6, default"
              #];
               bezier    = "myBezier, 0.25, 0.9, 0.1, 1.02";
               animation = [
                  "windows, 1, 7, myBezier"
                  "windowsOut, 1, 7, default, popin 80%"
                  "border, 1, 10, default"
                  "borderangle, 1, 8, default"
                  "fade, 1, 7, default"
                 #"workspaces, 1, 3, default, slidevert"
                 #"workspaces, 1, 3, myBezier, slidefadevert"
                  "workspaces, 1, 3, myBezier, fade"
               ];
            };
            
            
            dwindle = {
               pseudotile     = true;
               preserve_split = true;
            };
            
            
            master = {
               new_status    = "master";
               new_is_master = true;
              #orientation   = "center";
               # TODO
            };
            
            
            gestures = {
               workspace_swipe = false;
            };
            
            
            # device = {
            #    name        = "epic-mouse-v1";
            #    sensitivity = -0.5;
            # ];
            
            
            misc = {
              #force_default_wallpaper = 0;
               disable_hyprland_logo   = true;
            };
            
            
            # TODO: Set elsewhere? Or at least use variables.
            input = {
               kb_layout    = "se";
               kb_model     = "pc104";
              #kb_variant   = ???;
              #kb_options   = ???;
              #kb_rules     = ???;
               follow_mouse = 1;
               sensitivity  = 0; # -1.0 - 1.0, 0 means no modification.
              #touchpad {
              #   natural_scroll = false;
              #};
            };
            
            
            "$mainMod" = if (osConfig.altIsSuper or false) then "ALT" else "SUPER";
            
            
            bind = [
               "$mainMod, T, exec, kitty"   # $terminal"
               "$mainMod, E, exec, dolphin" # $file_manager"
               "$mainMod, F, togglefloating,"
               "$mainMod, R, exec, rofi -show drun -show-icons" # $menu
               
               "$mainMod, Q, killactive,"  # C?
               "$mainMod, M, exit,"
               "$mainMod, P, pseudo,"      # Dwindle
               "$mainMod, J, togglesplit," # Dwindle
               
               # Regular:
               "$mainMod, left,  movefocus, l"
               "$mainMod, right, movefocus, r"
               "$mainMod, up,    movefocus, u"
               "$mainMod, down,  movefocus, d"
               # Vim:
               #"$mainMod, H, movefocus, l"
               #"$mainMod, L, movefocus, r"
               #"$mainMod, K, movefocus, u"
               #"$mainMod, J, movefocus, d"
               
               #", Print, exec grimblast copy area"
               
               
               
               #"$mainMod, return, exec, kitty"
               #"$mainMod, Q, killactive,"
               #"$mainMod SHIFT, M, exit,"
               #"$mainMod SHIFT, F, togglefloating,"
               #"$mainMod, F, fullscreen,"
               #"$mainMod, G, togglegroup,"
               #"$mainMod, bracketleft, changegroupactive, b"
               #"$mainMod, bracketright, changegroupactive, f"
               #"$mainMod, S, exec, rofi -show drun -show-icons"
               #"$mainMod, P, pin, active"
               #
               #"$mainMod, left, movefocus, l"
               #"$mainMod, right, movefocus, r"
               #"$mainMod, up, movefocus, u"
               #"$mainMod, down, movefocus, d"
               #
               #"$mainMod, h, movefocus, l"
               #"$mainMod, l, movefocus, r"
               #"$mainMod, k, movefocus, u"
               #"$mainMod, j, movefocus, d"
               #
               #"$mainMod SHIFT, h, movewindow, l"
               #"$mainMod SHIFT, l, movewindow, r"
               #"$mainMod SHIFT, k, movewindow, u"
               #"$mainMod SHIFT, j, movewindow, d"
            ]
            ++ map (n: "$mainMod SHIFT, ${toString n}, movetoworkspace, ${toString (
               if    n == 0
               then  10
               else  n
            )}") [1 2 3 4 5 6 7 8 9 0]
            ++ map (n: "$mainMod, ${toString n}, workspace, ${toString (
               if    n == 0
               then  10
               else  n
            )}") [1 2 3 4 5 6 7 8 9 0];
            
            
            # TODO: Make a toggle bind for arrow/vim?
            binde = [
               # Regular:
               "$mainMod SHIFT,  left,   moveactive, -20   0"
               "$mainMod SHIFT, right,   moveactive,  20   0"
               "$mainMod SHIFT,    up,   moveactive,   0 -20"
               "$mainMod SHIFT,  down,   moveactive,   0  20"
               
               "$mainMod  CTRL,  left, resizeactive, -30   0"
               "$mainMod  CTRL, right, resizeactive,  30   0"
               "$mainMod  CTRL,    up, resizeactive,   0 -10"
               "$mainMod  CTRL,  down, resizeactive,   0  10"
               
               # Vim:
               "$mainMod SHIFT,     H,   moveactive, -20   0"
               "$mainMod SHIFT,     L,   moveactive,  20   0"
               "$mainMod SHIFT,     K,   moveactive,   0 -20"
               "$mainMod SHIFT,     J,   moveactive,   0  20"
               
               "$mainMod  CTRL,     L, resizeactive,  30   0"
               "$mainMod  CTRL,     H, resizeactive, -30   0"
               "$mainMod  CTRL,     K, resizeactive,   0 -10"
               "$mainMod  CTRL,     J, resizeactive,   0  10"
            ];
            
            
            bindm = [
               "$mainMod, mouse:272, movewindow"   # resize on LMB drag
               "$mainMod, mouse:273, resizewindow" #   move on RMB drag
            ];
            
            
            exec-once = exec-once;
         }; # end-of: `config.wayland.windowManager.hyprland.settings`
      }; # end-of: `config.wayland.windowManager.hyprland`
      
      home.packages = with pkgs; [
         git
         libnotify       # (dependency of mako & dunst)
         mako            # Notification daemon for Hyprland (alt: dunst)
         grim            # Screenshot utility
         slurp           # Select utility
         swww            # Wallpaper system   (alt. hyprpaper|swaybg|wpaperd)
         wl-clipboard    # Clipboard (Wayland)
         rofi-wayland    # Application runner (alt: bemenu|fuzzel|tofi|wofi) (TODO: refactor out)
         waybar          # Bar                                               (TODO: refactor out)
         (waybar.overrideAttrs(
            oldAttrs: {
               mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
            }
         ))
         networkmanagerapplet
      ];
      
   }; # end-of: `config`
} # end-of: <module>

