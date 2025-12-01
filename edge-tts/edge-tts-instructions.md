# Instructions for edge-tts virtual env

Environment: Fedora

1. First load the AppArmor profile with `apparmor_parser` or copy the file into `/etc/apparmor.d/` (NOT USED because Fedora only supports SELinux)

1. Create the private home dir `mkdir -p ~/Dev/edge-tts/texts`

1. Change to the Downloads directory: `cd ~/Downloads/`

1. Download the scripts: `git clone --verbose --depth 1 https://github.com/HackTestes/Linux_VirtualEnvs ./LVE`

1. Change directory: `cd ./LVE/edge-tts/`

1. Load the container with `bash ./start-env-edge-tts.sh`

1. Install edge-tts with pip into the private home `pip install edge-tts`

1. Copy all the text into the container (host path: `~/Dev/edge-tts/texts`)

1. Generate text: `cd ~/texts && bash start-tts.sh`

## Security notes

* It denies access to
    * All devices, except for /dev/null
    * To most of the /run directory as it contains many important sockets (pipewire, wayland...)
    * /var contains links back to /run
    * Boot directory (access to the BIOS vars)
    * Sys directory for the same reason as the /run

* It uses a SECCOMP filter (allowlisting) based on the ones used by Flatpak and Android

* Clone and clone3
    * Namespacing is disallowed
    * Clone3 uses a memory buffer to pass arguments and can't be verified by SECCOMP, so it was completely blocked

* Socket
    * Only "normal" networking (no bluetooth, vsocks...)

* ioctl (SECCOMP)
    * It only allows TTY ioctl operations. However, the user must make sure that no other device is accessible since the same op codes can have different meanings depending on the device

* io_uring
    * Restricted by default since it can bypass SECCOMP filters by issuing system calls trough a memory buffer

## Debug

* Copied files from a Windows host might need: `dos2unix`
* File descirptor: `exec 6< hello.txt && read <& 6 && echo "${input}"`
* Use it to find sockets: `find /etc -type s,p 2>/dev/null`
    * If you need to find links: `find /bin -type l -exec ls -l {} \; 2>/dev/null`
    * CAREFUL with symlinks from `/var` -> `/run`

## Depends on

* Bubblewarp
* Libseccomp
* AppArmor (no longer needed)
* Python
* Pip

## Notes

* It is expected to use system binaries (yes I am sharing the host packages)

* The following path is expected to exist: /home/caioh/Dev/edge-tts
