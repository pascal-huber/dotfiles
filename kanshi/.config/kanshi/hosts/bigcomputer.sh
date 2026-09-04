#!/usr/bin/env bash
profile_all() {
    swaymsg output DP-2 enable mode 3440x1440@144Hz position 0 0 power on transform 0
    swaymsg output DP-3 enable mode 1920x1080 position 3440 0 power on transform 0
    swaymsg output HDMI-A-1 enable mode 1920x1080@120Hz position 5360 0 scale 1 power on
    # render_bit_depth 10 hdr on
}

profile_tv() {
    swaymsg output HDMI-A-1 enable mode 1920x1080@120Hz position 0 0 scale 1 power on
    swaymsg output DP-2 disable power off
    swaymsg output DP-3 disable power off
}

profile_tv4k() {
    swaymsg output HDMI-A-1 enable mode 3840x2160@60Hz position 0 0 scale 2 render_bit_depth 10 hdr on
    swaymsg output DP-2 disable power off
    swaymsg output DP-3 disable power off
}

profile_work() {
    swaymsg output DP-2 enable mode 3440x1440@144Hz position 0 0 power on transform 0
    swaymsg output DP-3 enable mode 1920x1080 position 3440 0 transform normal power on
    swaymsg output HDMI-A-1 disable power off
}

profile_work270() {
    swaymsg output DP-2 enable mode 3440x1440@144Hz position 0 0 transform normal power on
    swaymsg output DP-3 enable mode 1920x1080 position 3440 0 transform 270 power on
    swaymsg output HDMI-A-1 disable power off
}

profile_workmain() {
    swaymsg output DP-2 enable mode 3440x1440@144Hz position 0 0 power on
    swaymsg output DP-3 disable power off
    swaymsg output HDMI-A-1 disable
}

profile_workside() {
    swaymsg output DP-3 enable mode 2560x1440@60Hz position 0 0 transform normal power on
    swaymsg output DP-2 disable power off
    swaymsg output HDMI-A-1 disable
}

