extends Node2D
class_name Checkpoint

var activated : bool = false
@export var spawn_point : bool = false
@onready var lights: Node2D = $Lights

func _ready() -> void:
	if spawn_point:
		interact()

func interact() -> void:
	if activated != true:
		activated = true
		lights.visible = true
		GM.current_checkpoint = self
