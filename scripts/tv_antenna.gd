class_name TV_Antenna extends Node2D

signal stopped_holding

@export var angle :float = 45
@export var speed :float = 50.0
@export var acceptable_interests :Array[Interest]
@export var current_interest :Interest

@export_group("Signal Colors")
@export var no_signal_color :Color = Color.WHITE
@export var wrong_signal_color :Color = Color.RED
@export var correct_signal_color :Color = Color.GREEN
@export_range(0.0, 1.0, 0.1) var non_selected_alpha :float = 0.5
@export_range(0.0, 1.0, 0.1) var selected_alpha :float = 0.75

@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var tv_signal_sprite: Sprite2D = %TV_SpriteShader
@onready var head: Marker2D = %Head

var is_holding:bool = false

func _ready() -> void:
	set_color(null, false)
	set_alpha(false)
	select_random_interest()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse = event as InputEventMouseButton
		if mouse.is_released() and mouse.button_index == MOUSE_BUTTON_LEFT and is_holding:
			is_holding = false
			stopped_holding.emit()

func _process(delta: float) -> void:
	update_rotation(delta)



func update_rotation(delta:float) -> void:
	if not is_holding:
		return
	
	var target_rotation :float = clampf(get_global_mouse_position().x - global_position.x, -angle, angle)
	head.rotation_degrees = move_toward(head.rotation_degrees, target_rotation, delta * speed)


func select_random_interest() -> void:
	current_interest = acceptable_interests.pick_random()


func set_color(interest_channel:InterestChannel, is_entering:bool) -> void:
	if not is_entering:
		tv_signal_sprite.modulate = no_signal_color
		return
	
	if interest_channel == null:
		return
	
	tv_signal_sprite.modulate = correct_signal_color if interest_channel.interest == current_interest else wrong_signal_color

func set_alpha(is_selected:bool) -> void:
	var color :Color = Color(Color.WHITE, selected_alpha if is_selected else non_selected_alpha)
	
	var tween = get_tree().create_tween()
	tween.tween_property(tv_signal_sprite, "self_modulate", color, 0.1)

#region Signal Connections
func _on_mouse_detection_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse = event as InputEventMouseButton
		if mouse.pressed and mouse.button_index == MOUSE_BUTTON_LEFT:
			is_holding = true

func _on_mouse_detection_mouse_entered() -> void:
	set_alpha(true)


func _on_mouse_detection_mouse_exited() -> void:
	if is_holding:
		await stopped_holding
	
	set_alpha(false)


func _on_tv_signal_area_entered(area: Area2D) -> void:
	if area is InterestChannel:
		set_color(area as InterestChannel, true)

func _on_tv_signal_area_exited(area: Area2D) -> void:
	if area is InterestChannel:
		set_color(area as InterestChannel, false)
#endregion
