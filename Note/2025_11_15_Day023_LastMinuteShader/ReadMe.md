

# ✅ Simple Sprite Shader for Godot 4.5.1

### 1. Add a Mesh

* Add **MeshInstance3D** → give it a texture.

### 2. Add a ShaderMaterial

* Inspector → **Material** → **New ShaderMaterial**
* Click it → **New Shader**

### 3. Paste this shader (fully compatible with Godot 4.5.1):

```glsl
shader_type spatial;

render_mode unshaded;

uniform vec4 tint_color : source_color = vec4(1.0, 0.4, 0.4, 1.0);
uniform float pulse_speed = 2.0;

void fragment() {
    float pulse = 0.5 + 0.5 * sin(TIME * pulse_speed);
    ALBEDO = (tint_color.rgb * pulse);
    ALPHA = tint_color.a;
}

```
