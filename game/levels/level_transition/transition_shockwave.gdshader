shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 tex_color = texture(TEXTURE, UV);
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	float dist = distance(UV, vec2(0.5));

	if (dist < 0.1) {
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	} else if (tex_color == vec4(0.0, 0.0, 0.0, 1.0)) {
		COLOR = screen_color * 2.0;
		COLOR.a = dist * 2.0;
	} else {
		COLOR = tex_color;
	}
}