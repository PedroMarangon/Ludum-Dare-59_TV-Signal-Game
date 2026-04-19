@tool
class_name HouseSprite extends Node2D

@export_group("Colors")
@export var random_color :bool = true
@export var colors :Array[Color] = [Color.WHITE]
@export var single_color :Color = Color.WHITE

@onready var walls: Sprite2D = %Walls

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	%Walls.modulate = colors.pick_random() if random_color else single_color
