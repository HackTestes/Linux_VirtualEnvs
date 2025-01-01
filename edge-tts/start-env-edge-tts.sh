# Starts the environment for edge-tts

aa-exec -p aa_edge_tts bwrap --unshare-all --share-net \
--new-session \
--ro-bind / / \
--tmpfs /dev \
--bind /dev/null /dev/null \
--proc /proc \
--tmpfs /tmp \
--tmpfs /run \
--bind /run/systemd/resolve/stub-resolv.conf /run/systemd/resolve/stub-resolv.conf \
--tmpfs /home \
--bind /home/caioh/Dev/edge-tts /home \
/usr/bin/bash

