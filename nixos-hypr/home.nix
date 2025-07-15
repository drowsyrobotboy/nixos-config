# /etc/nixos/home.nix

{ pkgs, ... }:

{
  # Install your personal packages
  home.packages = with pkgs; [
    firefox
    alacritty
    wofi
    waybar
    vscode
    nerd-fonts.jetbrains-mono
    wl-clipboard
    grim
    slurp
  ];

  # Set environment variables
  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # Enable numLock
  xsession.numlock.enable = true;

  # Declarative dotfiles using Home Manager
  # Hyprland Configuration
  xdg.configFile."hypr/hyprland.conf".text = ''
    monitor=,preferred,auto,1
    exec-once = waybar & alacritty
    env = XCURSOR_SIZE,48
    input {
        kb_layout = us;
    }
    env = XKB_DEFAULT_LAYOUT,us
    general {
        gaps_in = 5
        gaps_out = 10
        border_size = 2
        col.active_border = 0x33ccffee
        col.inactive_border = 0x595959aa
        layout = dwindle
    }

    decoration {
        rounding = 5
    }

    animations {
        enabled = true
    }
    # == Keybinds ==
    # Using Left Alt as the main modifier key
    $mainMod = mod1
    bind = $mainMod, RETURN, exec, alacritty
    bind = $mainMod, Q, killactive,
    bind = $mainMod, M, exit,
    bind = $mainMod, D, exec, wofi --show drun
    bind = $mainMod, F, fullscreen
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
  '';

  # Waybar Configuration
  xdg.configFile."waybar/config".text = ''
    {
        "layer": "top", "position": "top", "height": 30,
        "modules-left": ["sway/workspaces"],
        "modules-center": ["sway/window"],
        "modules-right": ["pulseaudio", "network", "clock", "tray"],
        "sway/window": { "max-length": 50 },
        "clock": { "format": " {:%I:%M %p}" },
        "pulseaudio": { "format": "{volume}% {icon}", "format-muted": "", "format-icons": { "default": ["", ""] } },
        "network": { "format-wifi": "  {essid}", "format-ethernet": "󰈀", "format-disconnected": "⚠" },
        "tray": { "spacing": 10 }
    }
  '';

  # Waybar Styling
  xdg.configFile."waybar/style.css".text = ''
    * { border: none; font-family: "JetBrainsMono Nerd Font"; font-size: 14px; }
    window#waybar { background-color: rgba(26,26,26,0.8); color: #ffffff; }
    #workspaces button { padding: 0 5px; color: #ffffff; }
    #workspaces button:hover { background: rgba(0,0,0,0.2); }
    #workspaces button.focused { background-color: #64727D; }
    #clock, #pulseaudio, #network, #tray, #window { padding: 0 10px; color: #ffffff; }
  '';

  # Let Home Manager manage its own state
  home.stateVersion = "25.05";
}
