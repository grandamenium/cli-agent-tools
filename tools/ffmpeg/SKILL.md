---
name: ffmpeg-cli
description: Use FFmpeg to convert, process, and manipulate video and audio files from the terminal. Transcode formats, extract audio, create thumbnails, trim clips, and more.
---

# FFmpeg

The universal multimedia framework. Convert, process, and stream video and audio.

- **Official site:** https://ffmpeg.org
- **Docs:** https://ffmpeg.org/documentation.html

## Common Commands

### Format Conversion
```bash
ffmpeg -i input.mp4 output.webm                    # Convert MP4 to WebM
ffmpeg -i input.mov output.mp4                      # Convert MOV to MP4
ffmpeg -i input.wav output.mp3                      # Convert WAV to MP3
ffmpeg -i input.mp4 -c:v libx264 -crf 23 output.mp4  # Re-encode with H.264
```

### Extract Audio
```bash
ffmpeg -i video.mp4 -vn -acodec mp3 audio.mp3      # Extract audio as MP3
ffmpeg -i video.mp4 -vn -acodec pcm_s16le audio.wav # Extract as WAV
ffmpeg -i video.mp4 -vn -c:a copy audio.aac         # Extract without re-encoding
```

### Trim and Cut
```bash
ffmpeg -i input.mp4 -ss 00:01:00 -to 00:02:00 -c copy clip.mp4  # Cut 1:00-2:00
ffmpeg -i input.mp4 -ss 30 -t 10 -c copy clip.mp4               # 10 seconds starting at 30s
```

### Thumbnails and Screenshots
```bash
ffmpeg -i input.mp4 -ss 00:00:05 -frames:v 1 thumb.png          # Screenshot at 5s
ffmpeg -i input.mp4 -vf "fps=1/10" thumb_%04d.png               # One frame every 10s
ffmpeg -i input.mp4 -vf "thumbnail" -frames:v 1 best_thumb.png  # Best thumbnail
```

### Resize and Scale
```bash
ffmpeg -i input.mp4 -vf "scale=1280:720" output.mp4             # Resize to 720p
ffmpeg -i input.mp4 -vf "scale=-1:480" output.mp4               # Scale height, keep ratio
```

### GIF Creation
```bash
ffmpeg -i input.mp4 -ss 0 -t 5 -vf "fps=10,scale=320:-1" output.gif
```

### Concatenation
```bash
# Create file list: file 'clip1.mp4'\nfile 'clip2.mp4'
ffmpeg -f concat -safe 0 -i filelist.txt -c copy output.mp4
```

### Audio Processing
```bash
ffmpeg -i input.mp3 -af "volume=1.5" louder.mp3                 # Increase volume
ffmpeg -i input.mp3 -af "atempo=1.5" faster.mp3                 # Speed up audio
ffmpeg -i input.mp4 -an output_silent.mp4                       # Remove audio
```

### Probe (inspect file)
```bash
ffprobe -v quiet -print_format json -show_format -show_streams input.mp4
```

## Agent Best Practices

- Use `-c copy` when possible to avoid re-encoding (much faster)
- Use `ffprobe` to inspect files before processing
- Use `-y` flag to overwrite output without prompting
- Use `-hide_banner` to reduce noisy output
- CRF (Constant Rate Factor) controls quality: 18 = high, 23 = default, 28 = low
- Use `-preset ultrafast` for quick encodes, `-preset slow` for quality
- Pipe output to `/dev/null` and use `-progress pipe:1` for parseable progress

## Example Workflows

### Convert video for web
```bash
ffmpeg -y -hide_banner -i input.mov -c:v libx264 -crf 23 -preset medium -c:a aac -b:a 128k output.mp4
```

### Get video duration
```bash
ffprobe -v quiet -show_entries format=duration -of csv=p=0 input.mp4
```
