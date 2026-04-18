shader_type canvas_item;
render_mode blend_mix;

uniform vec2 offset = vec2(0,0);
uniform float angle = 45;
uniform float angle_edge : hint_range(0.0, 10.0, 0.1)  = 3.0;

uniform float ring_frequency = 50.0;

uniform float move_speed = -10.0;
uniform bool smooth_edge = false;
uniform bool smooth_edge_angle = false;


varying vec4 modulate_color;


float angle_mask(vec2 uv)
{
	vec2 centered_uv = uv - vec2(0.5) + offset;
	
	float rot = radians(180.0);
	
	mat2 rot_mat = mat2(
		vec2(cos(rot), -sin(rot)),
		vec2(sin(rot), -cos(rot))
	);
	
	vec2 dir = rot_mat * centered_uv;
	vec2 norm_dir = normalize(dir);
	
	vec2 forward = vec2(0.0, -1.0);
	float my_angle = degrees(acos(dot(norm_dir, forward)));
	
	float half_fov = angle * 0.5;
	return smooth_edge_angle ? smoothstep(my_angle - angle_edge, my_angle, half_fov) : step(my_angle, half_fov);
}


void vertex() {
	modulate_color = COLOR;
}


void fragment() {
	float dist = distance(UV + offset, vec2(0.5,0.5));
	float rings = sin(dist * ring_frequency + (TIME * move_speed));
	
	rings = step(0.9, rings);
	float blend_alpha = smoothstep(0.5, 0.4, dist);
	
	
	if (dist > 0.5 || rings < 1.0){
		COLOR.a = 0.0;
	}
	else if (rings > 0.0){
		COLOR.a = (smooth_edge ? blend_alpha : 1.0) * angle_mask(UV) * modulate_color.a;
	}
	
	COLOR.rgb = modulate_color.rgb;
}
