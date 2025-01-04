# Instructions for edge-tts virtual env

Environment: Ubuntu

1. First load the AppArmor profile with `apparmor_parser` or copy the file into `/etc/apparmor.d/`

1. Load the container with `./start-env-edge-tts.sh`

1. Activate python venv: `source /home/edge-tts/bin/activate` 

1. Generate text: `edge-tts --voice pt-BR-FranciscaNeural --file /home/texts/*.txt --write-media /home/texts/*.mp3`

## Depends on

* Bubblewarp
* AppArmor
* Python
* Pip

## Notes

* It is expected to use system binaries (yes I am sharing the host packages)

* The following path is expected to exist: /home/caioh/Dev/edge-tts
