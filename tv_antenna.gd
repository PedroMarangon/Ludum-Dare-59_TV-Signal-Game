class_name TV_Antenna extends Node2D

@export var angle :float = 45
@export var speed :float = 50.0

@onready var sprite_2d: Sprite2D = $Sprite2D

var is_holding:bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse = event as InputEventMouseButton
		if mouse.is_released() and mouse.button_index == MOUSE_BUTTON_LEFT and is_holding:
			print("Stopped holding")
			is_holding = false


func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse = event as InputEventMouseButton
		if mouse.pressed and mouse.button_index == MOUSE_BUTTON_LEFT:
			print("holding on sprite")
			is_holding = true

func _process(delta: float) -> void:
	if not is_holding:
		return
	var mouse_x :float = get_global_mouse_position().x
	var my_x :float = global_position.x
	
	
	rotation_degrees = move_toward(rotation_degrees, clampf(mouse_x - my_x, -angle, angle), delta * speed)


func _on_tv_signal_area_entered(area: Area2D) -> void:
	if area is InterestChannel:
			var interest = area as InterestChannel
			print(interest.interest_name, " ENTER")


func _on_tv_signal_area_exited(area: Area2D) -> void:
	if area is InterestChannel:
			var interest = area as InterestChannel
			print(interest.interest_name, " EXIT")
