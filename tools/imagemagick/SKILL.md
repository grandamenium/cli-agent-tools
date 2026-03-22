---
name: imagemagick-cli
description: Use ImageMagick (magick/convert) to resize, crop, convert, annotate, and process images from the terminal.
---

# ImageMagick

Image manipulation toolkit. Resize, crop, convert, composite, and annotate images in 200+ formats.

- **Official site:** https://imagemagick.org
- **Docs:** https://imagemagick.org/script/command-line-processing.php

## Common Commands

### Format Conversion
```bash
magick input.png output.jpg                          # PNG to JPEG
magick input.svg output.png                          # SVG to PNG
magick input.webp output.png                         # WebP to PNG
magick *.jpg output.pdf                              # Multiple images to PDF
```

### Resize
```bash
magick input.png -resize 800x600 output.png          # Resize to fit within 800x600
magick input.png -resize 50% output.png              # Scale to 50%
magick input.png -resize 800x600! output.png         # Force exact dimensions (distort)
magick input.png -resize 800x600^ -gravity center -extent 800x600 output.png  # Fill and crop
```

### Crop
```bash
magick input.png -crop 400x300+100+50 output.png     # Crop 400x300 at offset (100,50)
magick input.png -gravity center -crop 400x300+0+0 output.png  # Center crop
magick input.png -trim output.png                     # Auto-trim whitespace
```

### Quality and Compression
```bash
magick input.png -quality 85 output.jpg               # JPEG quality
magick input.png -strip output.png                    # Remove metadata
magick input.png -colors 256 output.png               # Reduce colors
```

### Annotate and Draw
```bash
magick input.png -pointsize 24 -fill white -gravity south -annotate +0+10 "Caption" output.png
magick input.png -fill red -draw "circle 100,100 150,100" output.png
```

### Composite and Overlay
```bash
magick base.png overlay.png -gravity southeast -composite output.png
magick base.png -page +10+10 watermark.png -flatten output.png
```

### Batch Processing
```bash
magick mogrify -resize 800x600 -path ./resized *.jpg  # Batch resize to directory
magick mogrify -format png *.jpg                       # Batch convert format
```

### Info
```bash
magick identify input.png                              # Basic info
magick identify -verbose input.png                     # Detailed info
magick identify -format "%wx%h" input.png              # Just dimensions
```

## Agent Best Practices

- Use `magick` (v7) instead of `convert` (v6 legacy)
- Use `magick identify` to inspect images before processing
- Use `magick mogrify` for in-place or batch operations
- Use `-strip` to remove EXIF data for smaller files
- Use `-quality 85` for JPEG - good balance of size and quality
- Chain operations in a single command for efficiency
- Use `-gravity` with `-extent` for precise cropping

## Example Workflows

### Create a thumbnail
```bash
magick input.jpg -resize 200x200^ -gravity center -extent 200x200 -quality 85 thumb.jpg
```

### Get image dimensions
```bash
magick identify -format "%w %h" input.png
```
