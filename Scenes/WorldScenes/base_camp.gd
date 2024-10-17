extends Node2D
@onready var marker_2d: Marker2D = $Marker2D

func _ready() -> void:
	GM.current_scene = self
	if GM.player != null:
		GM.player.position = marker_2d.global_position
