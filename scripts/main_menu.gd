class_name MainMenu extends CanvasLayer


@onready var tutorial_container: PanelContainer = %TutorialContainer


@export_group("Logo")
@export var logo_rotation :Vector2 = Vector2(0.2, 0.007)
@export var logo_scale :Vector2 = Vector2(0.2, 0.007)

var tween :Tween

const TUT_IN_SCREEN :float = 50.0
const TUT_OUT_SCREEN :float = -700.0


func _ready() -> void:
	get_tree().paused = false
	tutorial_container.position.x = TUT_OUT_SCREEN

func _process(_delta: float) -> void:
	if %TextureRect == null:
		return
	%TextureRect.rotation_degrees = sin(Time.get_ticks_msec() * logo_rotation.y * _delta) * logo_rotation.x
	%TextureRect.scale = Vector2.ONE + Vector2.ONE * cos(Time.get_ticks_msec() * logo_scale.y * _delta) * logo_scale.x

func move_tutorial(target_pos:float) -> void:
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(tutorial_container, "position:x", target_pos, 0.3)


#region Buttons
func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_tutorial_btn_pressed() -> void:
	if tutorial_container.position.x == TUT_OUT_SCREEN:
		move_tutorial(TUT_IN_SCREEN)
	else:
		move_tutorial(TUT_OUT_SCREEN)

func _on_quit_btn_pressed() -> void:
	get_tree().exit()


func _on_close_btn_pressed() -> void:
	move_tutorial(TUT_OUT_SCREEN)
#endregion
