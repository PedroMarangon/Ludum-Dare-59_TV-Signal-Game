class_name RemoveOnWebBuild extends Node

func _ready() -> void:
	if OS.has_feature("web"):
		get_parent().visible = false
