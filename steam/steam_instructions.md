# Instructions for creating the Steam container

* Create an Unconfined profile for AppArmor and load it (you can also load it at startup at `/etc/apparmorr.d/`)

```
sudo apparmor_parser --replace --warn all --abort-on-error /home/caioh/Documents/start_as/aa-uncofined-test
```

* Execute a new bash with the new profile (just load the profile in the application essentially)

```
aa-exec -p user_unconfined bash
```

* Execute Steam as a container with bubblewarp
```
bwrap --unshare-all --share-net \
--new-session \
--ro-bind / / \
--dev-bind /dev /dev \
--proc /proc \
--tmpfs /tmp \
--bind /run /run \
--bind /media/caioh/SSD_2/steam /home \
/usr/bin/bash

```


```
bwrap --unshare-all --share-net \
--new-session \
--ro-bind /bin /bin \
--ro-bind /etc /etc \
--ro-bind /lib /lib \
--ro-bind /lib64 /lib64 \
--ro-bind /opt /opt \
--ro-bind /sbin /sbin \
--ro-bind /srv /srv \
--ro-bind /sys /sys \
--ro-bind /usr /usr \
--ro-bind /var /var \
--dir /dev \
--dev-bind /dev/fd /dev/fd \
--dev-bind /dev/urandom /dev/urandom \
--dev-bind /dev/null /dev/null \
--dev-bind /dev/tty /dev/tty \
--dev-bind /dev/pts /dev/pts \
--dev-bind /dev/dri /dev/dri \
--dev-bind /dev/shm /dev/shm \
--dev-bind /dev/input /dev/input \
--dev-bind /dev/disk /dev/disk \
--dev-bind /dev/nvidiactl /dev/nvidiactl \
--dev-bind /dev/nvidia0 /dev/nvidia0 \
--dev-bind /dev/nvidia-modeset /dev/nvidia-modeset \
--dev-bind /dev/nvidia-uvm /dev/nvidia-uvm \
--dev-bind /dev/nvidia-uvm-tools /dev/nvidia-uvm-tools \
--dev-bind /dev/nvidia-caps /dev/nvidia-caps \
--proc /proc \
--tmpfs /tmp \
--dir /run \
--dir /run/user \
--dir /run/user/1000/ \
--bind /run/user/1000/xauth_* /run/user/1000/xauth_* \
--bind /run/user/1000/wayland-0 /run/user/1000/wayland-0 \
--ro-bind /run/systemd /run/systemd \
--bind /run/udev /run/udev \
--bind /media/caioh/SSD_2/steam /home \
/usr/bin/bash

```

```
bwrap --unshare-all --share-net \
--new-session \
--ro-bind /bin /bin \
--ro-bind /etc /etc \
--ro-bind /lib /lib \
--ro-bind /lib64 /lib64 \
--ro-bind /opt /opt \
--ro-bind /sbin /sbin \
--ro-bind /srv /srv \
--ro-bind /sys /sys \
--ro-bind /usr /usr \
--ro-bind /var /var \
--dev-bind /dev /dev \
--proc /proc \
--tmpfs /tmp \
--dir /run \
--dir /run/user \
--dir /run/user/1000/ \
--bind /run/user/1000/xauth_* /run/user/1000/xauth_* \
--bind /run/user/1000/wayland-0 /run/user/1000/wayland-0 \
--ro-bind /run/systemd /run/systemd \
--bind /run/udev /run/udev \
--bind /media/caioh/SSD_2/steam /home \
/usr/bin/bash

```

