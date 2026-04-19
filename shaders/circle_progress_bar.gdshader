shader_type canvas_item;
render_mode blend_mix;


uniform vec3 background_color : source_color = vec3(0);
uniform vec3 foreground_color : source_color = vec3(1);

uniform float fill :hint_range(0.0, 1.0, 0.01) = 0.5;

uniform float width :hint_range(0.0, 0.5, 0.01) = 0.1;
uniform float size :hint_range(0.0, 0.5, 0.01) = 0.5;


vec2 to_polar(vec2 uv)
{
	vec2 dir = uv - vec2(0.5, 0.5);
	float radius = length(dir) * 2.0;
	float angle = (atan(dir.y, dir.x) * 1.0 / (PI * 2.0));
	return vec2(radius, angle);
}

float remap(float v, vec2 in_min_max, vec2 out_min_max)
{
	float p1 = (v - in_min_max.x) * (out_min_max.y - out_min_max.x);
	return out_min_max.x + (p1 / (in_min_max.y - in_min_max.x));
}

void fragment() {
	float dist = distance(UV, vec2(0.5,0.5));
	
	if (dist > size || dist < size- width){
		COLOR.a = 0.0;
	}
	
	vec2 polar = to_polar(UV);
	
	float edge = remap(polar.g, vec2(-1.0,1.0), vec2(0.0,1.0));
	
	float my_fill = fill < 0.5 ? remap(fill, vec2(0,0.5), vec2(0.25, 0.5)) : remap(fill, vec2(0.5,1), vec2(0.5, 0.75));
	
	float percentage = step(edge, my_fill);
	
	COLOR.rgb = percentage > 0.5 ? foreground_color : background_color;
	
}
