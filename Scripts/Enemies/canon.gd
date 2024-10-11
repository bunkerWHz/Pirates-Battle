extends StaticBody2D

var cannon_ball = preload("res://Scenes/Enemies/cannon_ball.tscn")
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var firepoint: Marker2D = $Firepoint
@export var shooting : bool = false
var firerate = 2

func _on_detect_player_area_entered(area) -> void:
	if area is Player:
		pass

func _ready() -> void:
	shooting = true
	shoot()
	
func shoot() -> void:
	while shooting:
		animation.play("attack")
		await get_tree().create_timer(firerate).timeout
		
		
func fire() -> void:
	var spawned_ball = cannon_ball.instantiate()
	spawned_ball.direction = firepoint.scale.x
	spawned_ball.global_position = firepoint.position
	add_child(spawned_ball)
