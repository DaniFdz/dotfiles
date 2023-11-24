{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    style = ''
      ${builtins.readFile ./style.css} 
    '';

    settings = {
      layer = "top";
      position = "top";
      height = 10;
      margin-bottom = 0;
      margin-top = 0;

      modules-left = [
        "sway/mode"
        "cpu"
        "memory"
        "network"
        "mpd"
      ];
      modules-center = [
        "sway/workspaces"
        "hyperland/workspaces"
      ];
      modules-right = [
        "tray"
        "idle_inhibitor"
        "pulseaudio"
        "backlight"
        "battery"
        "clock"
      ];

      "sway/mode" = {
        format = "<span style=\"italic\">{}</span>";
      };
      "tray" = {
        icon-size = 16;
        spacing = 6;
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          "activated" = "";
          "deactivated" = "";
        };
      };
      "clock" = {
        locale = "C";
        format = " {:%I:%M %p}";
        format-alt = " {:%a,%b %d}";
      };
      "cpu" = {
        format = "&#8239;{usage}%";
        tooltip = false;
        on-click = "kitty -e 'htop'";
      };
      "memory" = {
        interval = 30;
        format = " {used:0.2f}GB";
        max-length = 10;
        tooltip = false;
        warning = 70;
        critical = 90;
      };
      "network" = {
        interval = 2;
        format-wifi = " {signalStrength}%";
        format-ethernet = "";
        format-linked = " {ipaddr}";
        format-disconnected = " Disconnected";
        format-disabled = "";
        tooltip = false;
        max-length = 20;
        min-length = 6;
        format-alt = "{essid}";
      };
      "backlight" = {
        format = "{icon}&#8239;{percent}%";
        format-icons = ["" ""];
        on-scroll-down = "brightnessctl -c backlight set 1%-";
        on-scroll-up = "brightnessctl -c backlight set +1%";
      };
      "pulseaudio" = {
        format = "{icon} {volume}% {format_source}";
        format-bluetooth = "{icon} {volume}% {format_source}";
        format-bluetooth-muted = " {format_source}";
        format-muted = " {format_source}";
        format-source = " {volume}%";
        format-source-muted = "";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "🎧";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
        on-click = "pavucontrol";
      };
      "mpd" = {
        format = "{stateIcon} {artist} - {title}";
        format-disconnected = "🎶";
        format-stopped = "♪";
        interval = 10;
        consume-icons = {
          on = " ";
        };
        random-icons = {
          off = "<span color=\"#f53c3c\"></span> ";
          on = " ";
        };
        repeat-icons = {
          on = " ";
        };
        single-icons = {
          on = "1 ";
        };
        state-icons = {
          paused = "";
          playing = "";
        };
        tooltip-format = "MPD (connected)";
        tooltip-format-disconnected = "MPD (disconnected)";
        max-length = 35;
      };
    };
  };
}
