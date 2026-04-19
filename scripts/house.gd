@tool
class_name House extends Node2D

@export_group("Colors")
@export var random_color :bool = true
@export var colors :Array[Color] = [Color.WHITE]
@export var single_color :Color = Color.WHITE

@onready var walls: Sprite2D = %Walls
@onready var ui: Control = %UI
@onready var texture_rect: TextureRect = %TextureRect
@onready var progress: ColorRect = %Progress

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	%Walls.modulate = colors.pick_random() if random_color else single_color
	ui.scale = Vector2.ZERO
	update_progress(0)

func update_progress(percentage:float) -> void:
	progress.material.set("shader_parameter/fill", percentage)

func switch_content(interest:Interest) -> void:
	var tween = get_tree().create_tween()
	
	if ui.scale != Vector2.ZERO:
		tween.tween_property(ui, "scale", Vector2.ZERO, 0.5)
		tween = tween.chain()
	
	tween.tween_method(func(): update_progress(0), self, self, 0.1)
	tween.tween_property(texture_rect, "texture", interest.icon, 0.1)
	tween.chain().tween_property(ui, "scale", Vector2.ONE, 0.5)
	
