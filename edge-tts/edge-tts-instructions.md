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
    * Sys directory for the same reason as the 

## Depends on

* Bubblewarp
* AppArmor
* Python
* Pip

## Notes

* It is expected to use system binaries (yes I am sharing the host packages)

* The following path is expected to exist: /home/caioh/Dev/edge-tts
