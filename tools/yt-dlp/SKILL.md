---
name: yt-dlp-cli
description: Use yt-dlp to download videos and audio from YouTube, Vimeo, Twitter, and 1000+ other sites. Extract metadata, select formats, and convert media.
---

# yt-dlp

Feature-rich video/audio downloader. Supports YouTube, Vimeo, Twitter, and 1000+ sites.

- **Official repo:** https://github.com/yt-dlp/yt-dlp
- **Docs:** https://github.com/yt-dlp/yt-dlp#usage-and-options

## Common Commands

### Download Video
```bash
yt-dlp "https://youtube.com/watch?v=VIDEO_ID"                # Default best quality
yt-dlp -f "bestvideo+bestaudio" URL                           # Best video + audio
yt-dlp -f "bestvideo[height<=720]+bestaudio" URL              # Max 720p
yt-dlp -f "best[height<=480]" URL                             # Max 480p single file
```

### Download Audio Only
```bash
yt-dlp -x URL                                                 # Extract audio (best format)
yt-dlp -x --audio-format mp3 URL                              # Convert to MP3
yt-dlp -x --audio-format wav URL                              # Convert to WAV
yt-dlp -x --audio-quality 0 URL                               # Best audio quality
```

### List Formats
```bash
yt-dlp -F URL                                                 # List available formats
yt-dlp -f 22 URL                                              # Download specific format ID
```

### Output Naming
```bash
yt-dlp -o "%(title)s.%(ext)s" URL                             # Title as filename
yt-dlp -o "%(uploader)s/%(title)s.%(ext)s" URL                # Organize by uploader
yt-dlp -o "/tmp/%(title)s.%(ext)s" URL                        # Specific directory
```

### Metadata
```bash
yt-dlp --print title URL                                      # Print title only
yt-dlp --print duration URL                                   # Print duration
yt-dlp -j URL                                                 # Full metadata as JSON
yt-dlp --write-info-json URL                                  # Save metadata file
yt-dlp --write-thumbnail URL                                  # Download thumbnail
yt-dlp --write-subs --sub-lang en URL                         # Download subtitles
yt-dlp --write-auto-subs --sub-lang en URL                    # Auto-generated subs
```

### Playlists
```bash
yt-dlp --flat-playlist -j URL                                 # List playlist entries
yt-dlp --playlist-items 1-5 URL                               # Download first 5
yt-dlp -I 1:10 URL                                            # Items 1 through 10
```

### Advanced
```bash
yt-dlp --sponsorblock-remove all URL                          # Remove sponsor segments
yt-dlp --embed-thumbnail --embed-subs URL                     # Embed metadata
yt-dlp --cookies-from-browser chrome URL                      # Use browser cookies
yt-dlp --download-archive archive.txt URL                     # Skip already downloaded
```

## Agent Best Practices

- Use `-j` (JSON) for metadata extraction without downloading
- Use `--print` for specific fields: `--print title`, `--print duration`
- Use `-x --audio-format mp3` for podcast/audio extraction
- Use `--flat-playlist -j` to list playlist contents without downloading
- Use `-f "bestvideo[height<=720]+bestaudio"` to balance quality and size
- Use `--download-archive` for incremental downloads
- Always respect copyright and terms of service

## Example Workflows

### Get video metadata
```bash
yt-dlp -j "URL" | jq '{title, duration, view_count, upload_date}'
```

### Download audio from playlist
```bash
yt-dlp -x --audio-format mp3 -o "%(playlist_index)s-%(title)s.%(ext)s" "PLAYLIST_URL"
```
