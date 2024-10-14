extends StaticBody2D

var cannon_ball = preload("res://Scenes/Enemies/cannon_ball.tscn")
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var firepoint: Marker2D = $Firepoint
@export var shooting : bool = false
@export var firerate: float = 1.5

func shoot() -> void:
	while shooting:
		await get_tree().create_timer(firerate).timeout
		animation.play("attack")
		
func fire() -> void:
	var spawned_ball = cannon_ball.instantiate()
	spawned_ball.direction = firepoint.scale.x * -1
	spawned_ball.global_position = firepoint.position
	add_child(spawned_ball)

func _on_detect_player_body_entered(body: Player) -> void:
	if body is Player:
		shooting = true
		shoot()


func _on_detect_player_body_exited(body) -> void:
	if body is Player:
		shooting = false
