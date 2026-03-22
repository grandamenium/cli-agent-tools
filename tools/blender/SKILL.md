---
name: blender-cli
description: Use Blender from the command line to render 3D scenes, run Python scripts for batch processing, and convert 3D file formats without the GUI.
---

# Blender CLI

3D creation suite with full command-line interface. Render scenes, batch process, and run Python scripts headlessly.

- **Official site:** https://www.blender.org
- **Docs:** https://docs.blender.org/manual/en/latest/advanced/command_line/arguments.html

## Common Commands

### Rendering
```bash
blender -b scene.blend -o /tmp/frame_ -f 1                    # Render frame 1
blender -b scene.blend -o /tmp/frame_ -s 1 -e 250 -a          # Render animation (frames 1-250)
blender -b scene.blend -o /tmp/render.png -f 1 -F PNG          # Render as PNG
blender -b scene.blend -o /tmp/render_ -F OPEN_EXR -a          # Render as OpenEXR
```

### Engine Selection
```bash
blender -b scene.blend -E CYCLES -f 1                          # Render with Cycles
blender -b scene.blend -E BLENDER_EEVEE_NEXT -f 1              # Render with EEVEE
```

### Resolution
```bash
blender -b scene.blend -o /tmp/out -x 1920 -y 1080 -f 1       # Custom resolution
```

### Python Scripting
```bash
blender -b --python script.py                                   # Run Python script
blender -b scene.blend --python script.py                       # Run script on file
blender -b --python-expr "import bpy; print(bpy.data.objects.keys())"  # Inline Python
```

### File Conversion
```bash
# Import/export via Python script
blender -b --python-expr "
import bpy
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.fbx(filepath='model.fbx')
bpy.ops.wm.save_as_mainfile(filepath='model.blend')
"

# Export to glTF
blender -b model.blend --python-expr "
import bpy
bpy.ops.export_scene.gltf(filepath='model.glb', export_format='GLB')
"
```

### Scene Info
```bash
blender -b scene.blend --python-expr "
import bpy
for obj in bpy.data.objects:
    print(f'{obj.name}: {obj.type}')
"
```

## Agent Best Practices

- Always use `-b` (background) flag for headless/CLI operation
- Use `-o` to set output path, `-f` for single frame, `-a` for animation
- Use `--python` or `--python-expr` for automation and batch processing
- Use `-F` to set output format: PNG, JPEG, OPEN_EXR, FFMPEG
- CYCLES is higher quality but slower; EEVEE is faster for previews
- Use `--python-text` to run a text block already in the .blend file
- Check Blender's Python API docs for scripting: https://docs.blender.org/api/current/

## Example Workflows

### Batch render a scene
```bash
blender -b scene.blend -E CYCLES -o /tmp/renders/frame_ -s 1 -e 100 -a
```

### Convert FBX to glTF
```bash
blender -b --python-expr "
import bpy
bpy.ops.wm.read_factory_settings(use_empty=True)
bpy.ops.import_scene.fbx(filepath='input.fbx')
bpy.ops.export_scene.gltf(filepath='output.glb', export_format='GLB')
"
```
