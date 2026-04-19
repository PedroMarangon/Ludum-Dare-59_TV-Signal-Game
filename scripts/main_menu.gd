class_name MainMenu extends CanvasLayer


@export var scene_to_load :PackedScene

@export var logo_rotation :Vector2 = Vector2(0.2, 0.007)
@export var logo_scale :Vector2 = Vector2(0.2, 0.007)


func _ready() -> void:
	if %TextureRect == null:
		return
	%TextureRect.rotation_degrees = sin(Time.get_ticks_msec() * logo_rotation.y) * logo_rotation.x
	%TextureRect.scale = Vector2.ONE + Vector2.ONE * cos(Time.get_ticks_msec() * logo_scale.y) * logo_scale.x

func _process(_delta: float) -> void:
	if %TextureRect == null:
		return
	%TextureRect.rotation_degrees = sin(Time.get_ticks_msec() * logo_rotation.y * _delta) * logo_rotation.x
	%TextureRect.scale = Vector2.ONE + Vector2.ONE * cos(Time.get_ticks_msec() * logo_scale.y * _delta) * logo_scale.x



func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_packed(scene_to_load)


func _on_credits_btn_pressed() -> void:
	print("AA")


func _on_quit_btn_pressed() -> void:
	get_tree().exit()
