shader_type canvas_item;

uniform float radius : hint_range(0.0, 1.5) = 0.0;
uniform vec2 center = vec2(0.5, 0.5);

void fragment() {
    vec2 uv = UV;

    // Corrige a proporção da tela (aspect ratio)
    float aspect = SCREEN_PIXEL_SIZE.y / SCREEN_PIXEL_SIZE.x;
    uv.x *= aspect;
    vec2 c = center;
    c.x *= aspect;

    float dist = distance(uv, c);

    if (dist < radius) {
        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0);
    }
}