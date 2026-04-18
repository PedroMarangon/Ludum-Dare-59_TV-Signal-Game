class_name InterestChannel extends Area2D


@export var interest :Interest


func _ready() -> void:
	if interest != null and interest.icon != null:
		$Sprite2D.texture = interest.icon
		$Sprite2D.modulate = Color.WHITE
