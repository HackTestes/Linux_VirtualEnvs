bwrap --unshare-user --ro-bind / / \
--dev-bind /dev /dev \
--proc /proc \
--tmpfs /tmp \
--bind /run /run \
--tmpfs /run/user \
--bind /run/user/1000/wayland-0 /run/user/1000/wayland-0 \
--bind /run/user/1000/wayland-0.lock /run/user/1000/wayland-0.lock \
--bind /run/user/1000/update-notifier.pid /run/user/1000/update-notifier.pid \
--bind /run/user/1000/systemd /run/user/1000/systemd \
--bind /run/user/1000/speech-dispatcher /run/user/1000/speech-dispatcher \
--bind /run/user/1000/pulse /run/user/1000/pulse \
--bind /run/user/1000/pipewire-0 /run/user/1000/pipewire-0 \
--bind /run/user/1000/pipewire-0.lock /run/user/1000/pipewire-0.lock \
--bind /run/user/1000/pipewire-0-manager /run/user/1000/pipewire-0-manager \
--bind /run/user/1000/pipewire-0-manager.lock /run/user/1000/pipewire-0-manager.lock \
--bind /run/user/1000/dconf /run/user/1000/dconf \
--bind /run/user/1000/dbus-1 /run/user/1000/dbus-1 \
--bind /run/user/1000/at-spi /run/user/1000/at-spi \
--bind /run/user/1000/doc /run/user/1000/doc \
--bind /run/user/1000/gnome-shell /run/user/1000/gnome-shell \
--bind /run/user/1000/gcr /run/user/1000/gcr \
--bind /run/user/1000/gvfs /run/user/1000/gvfs \
--bind /run/user/1000/gvfsd /run/user/1000/gvfsd \
--bind /run/user/1000/ICEauthority /run/user/1000/ICEauthority \
--bind /run/user/1000/gnome-session-leader-fifo /run/user/1000/gnome-session-leader-fifo \
--tmpfs /home \
/usr/bin/bash

