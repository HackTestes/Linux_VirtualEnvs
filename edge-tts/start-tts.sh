# Limit the amount of jobs so the client doesn't get flagged/mistaken for DoS
MAX_JOBS=10

# Chnage to the texts directory
cd ~/texts &&

# Get all the text files and transform them info .mp3 files (in other words, run the tts)
# See: https://stackoverflow.com/a/3894463
ls *.txt | sed 's/\..*//' | xargs -i --max-procs=$MAX_JOBS bash -c "edge-tts --voice pt-BR-FranciscaNeural --file {}.txt --write-media {}.mp3" &&

# Transform all the mp3 files into .mp4
# Since this is all local, there is no need to limit the amount of jobs
# ffmpeg explanation
# -f fmt: select format/input device
# -i input: input data
# -shortest: Finish encoding when the shortest input stream ends (if this is not used, the output grows infinitely)
ls *.mp3 | sed 's/\..*//' | xargs -i --max-procs=0 bash -c "ffmpeg -f lavfi -i color=c=black:s=192x144 -i {}.mp3 -y -shortest {}.mp4"