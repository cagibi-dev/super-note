shader_type canvas_item;
render_mode blend_add;

uniform sampler2D color_gradient;
uniform sampler2D noiseTexture;
uniform float speed: hint_range (-2.0, 2.0);
uniform float variation: hint_range (-1.0, 1.0);
uniform float width: hint_range (-1.0, 1.0);

void fragment() {
	vec2 noise_uv = mod(vec2(UV.x+TIME*speed, UV.y-TIME*speed), vec2(1.0));
	float noise_sample = texture(noiseTexture, noise_uv).r;
	float x_offset = noise_sample * variation - variation / 2.0;
	COLOR = texture(color_gradient,
		vec2((2.0 * distance(vec2(0.5), UV) - 0.75)/width + 0.5 + x_offset/width,
		0.0));
}
