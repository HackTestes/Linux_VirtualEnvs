# Instructions for edge-tts virtual env

Environment: Ubuntu

1. First load the AppArmor profile with `apparmor_parser` or copy the file into `/etc/apparmor.d/`

1. Load the container with `bash ./start-env-edge-tts.sh`

1. Create private home `mkdir ~`

1. Create pip virtual env `mkdir ~/edge-tts && python -m venv ~/edge-tts`

1. Activate python venv: `source ~/edge-tts/bin/activate`

1. Download edge-tts `pip install edge-tts`

1. Generate text: `edge-tts --voice pt-BR-FranciscaNeural --file /home/texts/*.txt --write-media /home/texts/*.mp3`

## Security notes

* It denies access to
    * All devices, except for /dev/null
    * To most of the /run directory as it contains many important sockets (pipewire, wayland...)
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

* Copied files from a Windows host might need: dos2unix
* File descirptor: `exec 6< hello.txt && read <& 6 && echo "${input}"`

## Depends on

* Bubblewarp
* AppArmor (no longer needed)
* Python
* Pip

## Notes

* It is expected to use system binaries (yes I am sharing the host packages)

* The following path is expected to exist: /home/caioh/Dev/edge-tts
