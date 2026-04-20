extends CanvasLayer

@export var day_logic: DayLogic

@onready var label: Label = %Label

@export_group("End Screen")
@export var url :String = "https://ldjam.com/events/ludum-dare/59/broadcast-alignment"

func _on_day_logic_on_hour_passed(hour: int, pm: bool) -> void:
	label.text = str(hour, " ", "PM" if pm else "AM")

func _on_day_logic_on_day_finished() -> void:
	get_tree().paused = true
	var tween = self.create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(%EndScreenContainer, "position:y", 0, 0.5)


func _on_ld_btn_pressed() -> void:
	OS.shell_open(url)


func _on_menu_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_quit_btn_pressed() -> void:
	get_tree().exit()
