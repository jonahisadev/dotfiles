#!/bin/bash

# wlroots
export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER=vulkan

export SDL_VIDEODRIVER=x11
export _JAVA_AWT_WM_NONREPARENTING=1
export QT_QPA_PLATFORM=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland
export XDG_RUNTIME_DIR=/run/user/1000
export MOZ_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export GDK_BACKEND="wayland,x11"
#export __GL_GSYNC_ALLOWED=0
#export __GL_VRR_ALLOWED=0
#export WLR_DRM_NO_ATOMIC=1
export GBM_BACKEND=nvidia-drm
#export __GLX_VENDOR_LIBRARY_NAME=nvidia
#export QT_QPA_PLATFORMTHEME=qt5ct

mkdir -p /tmp/1000 && chown -R jonah /tmp/1000

systemctl --user import-environment XDG_CURRENT_DESKTOP XDG_SESSION_DESKTOP XDG_SESSION_TYPE

dbus-run-session sway --unsupported-gpu
