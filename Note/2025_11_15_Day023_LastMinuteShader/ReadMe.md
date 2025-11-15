

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



```gdshader
shader_type spatial;
render_mode unshaded; // optional (lets you see the exact texture colors)

uniform sampler2D albedo_tex : source_color;

void fragment() {
    vec4 c = texture(albedo_tex, UV);

    // invert red + blue
    c.r = 1.0 - c.r;
    c.b = 1.0 - c.b;

    ALBEDO = c.rgb;
    ALPHA = c.a;
}

```

<img width="867" height="765" alt="image" src="https://github.com/user-attachments/assets/889e4548-19c4-4a99-9a33-ace617f5ec76" />
