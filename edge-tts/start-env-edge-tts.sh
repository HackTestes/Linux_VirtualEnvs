# Starts the environment for edge-tts

# Compile the SECCOMP filter
gcc ./SECCOMP_Filter.c -o init_seccomp.elf -lseccomp &&
./init_seccomp.elf > seccomp_filter.cbpf && # Export the filter
exec 4< ./seccomp_filter.cbpf && # Open as a read-only file descriptor

#aa-exec -p aa_edge_tts bwrap --unshare-all --share-net \
bwrap --unshare-all --share-net \
--new-session \
--die-with-parent \
--uid $(id -u) \
--gid $(id -g) \
--seccomp 4 \
--ro-bind /bin /bin \
--ro-bind /etc /etc \
--ro-bind /lib /lib \
--ro-bind /lib64 /lib64 \
--tmpfs /opt \
--ro-bind /sbin /sbin \
--tmpfs /srv \
--ro-bind /usr /usr \
--tmpfs /var \
--tmpfs /dev \
--dev-bind /dev/null /dev/null \
--proc /proc \
--tmpfs /tmp \
--tmpfs /run \
--dir /run/systemd \
--dir /run/systemd/resolve \
--ro-bind /run/systemd/resolve/stub-resolv.conf /run/systemd/resolve/stub-resolv.conf \
--tmpfs /home \
--bind ~/Dev/edge-tts /home/$USER \
setpriv --no-new-privs \
--landlock-access fs \
--landlock-rule path-beneath:execute,read-file,read-dir:/ \
--landlock-rule path-beneath:execute,write-file,read-file,read-dir,remove-dir,remove-file,make-char,make-dir,make-reg,make-sock,make-fifo,make-block,make-sym,refer,truncate:/dev \
--landlock-rule path-beneath:execute,write-file,read-file,read-dir,remove-dir,remove-file,make-char,make-dir,make-reg,make-sock,make-fifo,make-block,make-sym,refer,truncate:/home \
--landlock-rule path-beneath:execute,write-file,read-file,read-dir,remove-dir,remove-file,make-char,make-dir,make-reg,make-sock,make-fifo,make-block,make-sym,refer,truncate:/tmp \
/usr/bin/bash