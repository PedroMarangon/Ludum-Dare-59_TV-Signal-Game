@tool
class_name House extends Node2D

@export var enabled :bool = true

@export_group("Colors")
@export var random_color :bool = true:
	set(value):
		random_color = value
		if Engine.is_editor_hint():
			%Walls.modulate = single_color if not random_color else Color.WHITE
@export var colors :Array[Color] = [Color.WHITE]
@export var single_color :Color = Color.WHITE:
	set(value):
		single_color = value
		if Engine.is_editor_hint():
			%Walls.modulate = single_color if not random_color else Color.WHITE

@onready var walls: Sprite2D = %Walls
@onready var ui: Control = %UI
@onready var texture_rect: TextureRect = %TextureRect
@onready var progress: ColorRect = %Progress

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	ui.scale = Vector2.ZERO
	walls.modulate = colors.pick_random() if random_color else single_color
	
	if not enabled:
		return
	
	update_progress(0)

func update_progress(percentage:float) -> void:
	if not enabled:
		return
	
	progress.material.set("shader_parameter/fill", percentage)

func switch_content(interest:Interest) -> void:
	if not enabled:
		return
	
	var tween = get_tree().create_tween()
	
	if ui.scale != Vector2.ZERO:
		tween.tween_property(ui, "scale", Vector2.ZERO, 0.5)
		tween = tween.chain()
	
	tween.tween_callback(func(): update_progress(0))
	tween.tween_property(texture_rect, "texture", interest.icon, 0.1)
	tween.chain().tween_property(ui, "scale", Vector2.ONE, 0.5)
	
