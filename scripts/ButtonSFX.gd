class_name ButtonSFX extends Node


@export var button_click: AudioStreamOggVorbis = preload("uid://b82gqvsgo5ltu")
var player :AudioStreamPlayer

func _ready() -> void:
	player = AudioStreamPlayer.new()
	player.stream = button_click
	player.volume_db = -10.0
	add_child(player)
	
	(get_parent() as Button).pressed.connect(func(): player.play())
