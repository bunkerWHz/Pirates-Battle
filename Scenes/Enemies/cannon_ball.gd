extends Node2D

var direction
@export var speed : int = 200
@export var lifetime : float = 100
var hit : bool = false
@onready var animation: AnimationPlayer = $AnimationPlayer
@export var damage : float = 1
@onready var hit_box: HitBox = $HitBox

func _ready() -> void:
	await get_tree().create_timer(lifetime).timeout
	take_damage(1)
	
func take_damage(_value) -> void:
	hit = true
	speed = 0
	animation.play("hit")
	queue_free()
	
func _physics_process(delta: float) -> void:
	position.x += abs(speed * delta) * direction
