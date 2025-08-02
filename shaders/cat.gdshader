shader_type canvas_item;

uniform float flash_pct: hint_range(0.0, 1.0) = 0.0f;

void fragment() {
	vec4 original_color = texture(TEXTURE, UV);
	
	vec4 mixed = mix(original_color, vec4(1.0,1.0,1.0,1.0), flash_pct);
	COLOR = mixed;
	COLOR.a = original_color.a;
}
