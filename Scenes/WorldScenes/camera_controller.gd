extends Node2D
@export var speed = 200

func _process(delta: float) -> void:
	var axis = Input.get_axis("left","right")
	position.x += axis * speed * delta
