shader_type canvas_item;

uniform sampler2D star_noise :source_color, repeat_enable;
uniform float speed = 1.0;
uniform float cloud_power = 0.05;
uniform bool multiply_cloud = false;
uniform sampler2D clouds_noise :source_color, repeat_enable;

varying vec4 modulate;

void vertex() {
	modulate = COLOR;
}

void fragment() {
	vec4 star = texture(star_noise, UV);
	vec4 clouds = texture(clouds_noise, UV + TIME * 0.01 * vec2(speed, 0));
	COLOR = modulate + star;
	if(multiply_cloud) {
		COLOR *= (clouds * cloud_power);
	}
	else {
		COLOR += (clouds * cloud_power);
	}
	
	//if (star.x > 0.9)
	//{
		//COLOR.rgb += star.rgb;
	//}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
