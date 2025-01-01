# Instructions for edge-tts virtual env

Environment: Ubuntu

1. First load the AppArmor profile with `apparmor_parser` or copy the file into `/etc/apparmor.d/`

1. Load the container with `./start-env-edge-tts.sh`

## Depends on

* Bubblewarp
* AppArmor
* Python
* Pip

## Notes

* It is expected to use system binaries (yes I am sharing the host packages)

* The following path is expected to exist: /home/caioh/Dev/edge-tts
