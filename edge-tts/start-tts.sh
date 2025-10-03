# Limit the amount of jobs so the client doesn't get flagged/mistaken for DoS
MAX_JOBS=10

# Chnage to the texts directory
cd ~/texts &&

# Get all the text files and transform them info .mp3 files (in other words, run the tts)
# See: https://stackoverflow.com/a/3894463
ls *.txt | sed 's/\..*//' | xargs -i --max-procs=$MAX_JOBS bash -c "echo 'Generating {}.mp3...' && edge-tts --voice pt-BR-FranciscaNeural --file {}.txt --write-media {}.mp3 && echo 'Finished {}.mp3...'" &&

# Transform all the mp3 files into mp4
# Since this is all local, there is no need to limit the amount of jobs
# ffmpeg explanation
# -f lavfi -> device that generates the input (the color) - see: https://www.ffmpeg.org/ffmpeg-filters.html#allrgb_002c-allyuv_002c-color_002c-colorchart_002c-colorspectrum_002c-haldclutsrc_002c-nullsrc_002c-pal75bars_002c-pal100bars_002c-rgbtestsrc_002c-smptebars_002c-smptehdbars_002c-testsrc_002c-testsrc2_002c-yuvtestsrc
# color=c=black:s=1x1:r=1 -> color as black; resolution 1x1; fps to 1 (all to improve speed)
# -f fmt -> select format/input device
# -i input -> input data
# -c:v libopenh264 -> use H264 for encoding the video
# -c:a copy -> just copy the audio (lossless and increases speed a lot)
# -preset slow -> trade-off between compression and performance
# -r 1 -> output spf set to 1
# -shortest -> Finish encoding when the shortest input stream ends (if this is not used, the output grows infinitely)
#ls *.mp3 | sed 's/\..*//' | xargs -i --max-procs=0 bash -c "ffmpeg -f lavfi -i color=c=black:s=16x16:r=1 -i {}.mp3 -preset slow -y -shortest -c:v libopenh264 -c:a copy -r 1 {}.mp4"

# TEST COMMAND
# ffmpeg -f lavfi -i color=c=black:s=1x1:r=1 -i SistemaNacionalDeUnidadesDeConservacaoDaNatureza_9985_2000_altered.mp3 -preset slow -y -shortest -c:v libaom-av1 -c:a mp3 -r 1 SistemaNacionalDeUnidadesDeConservacaoDaNatureza_9985_2000_altered.mp4