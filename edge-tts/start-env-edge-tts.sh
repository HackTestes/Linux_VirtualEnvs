# Starts the environment for edge-tts

# Compile the SECCOMP filter
gcc ./SECCOMP_Filter.c -o init_seccomp.elf -lseccomp &&

#aa-exec -p aa_edge_tts bwrap --unshare-all --share-net \
bwrap --unshare-all --share-net \
--new-session \
--ro-bind /bin /bin \
--ro-bind /etc /etc \
--ro-bind /lib /lib \
--ro-bind /lib64 /lib64 \
--ro-bind /opt /opt \
--ro-bind /sbin /sbin \
--ro-bind /srv /srv \
--ro-bind /usr /usr \
--ro-bind /var /var \
--tmpfs /dev \
--dev-bind /dev/null /dev/null \
--proc /proc \
--tmpfs /tmp \
--tmpfs /run \
--dir /run/systemd \
--dir /run/systemd/resolve \
--ro-bind /run/systemd/resolve/stub-resolv.conf /run/systemd/resolve/stub-resolv.conf \
--tmpfs /home \
--bind ~/Dev/edge-tts /home \
--tmpfs /startup \
--ro-bind ./init_seccomp.elf /startup/init_seccomp.elf \
/startup/init_seccomp.elf \
/usr/bin/bash