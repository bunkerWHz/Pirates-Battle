extends Node2D

var direction
@export var speed : int = 200
@export var lifetime : float = 100
var hit : bool = false
@onready var animation: AnimationPlayer = $AnimationPlayer
@export var damage : float = 1

func _ready() -> void:
	await get_tree().create_timer(lifetime).timeout
	take_damage(1)
	
func take_damage(_value) -> void:
	hit = true
	speed = 0
	animation.play("hit")
	await animation.animation_finished
	queue_free()
	
func _physics_process(delta: float) -> void:
	position.x += abs(speed * delta) * direction


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body is Player:
		take_damage(1)


func _on_timer_timeout() -> void:
	queue_free()
