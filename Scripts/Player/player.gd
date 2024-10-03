extends CharacterBody2D
class_name Player

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@export var speed : float = 200
@export var jump_height : float = -300

var direction
		
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left","right")
	
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x) * 1
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_height
		
	if direction: 
		velocity.x = speed * direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	update_animation()
	move_and_slide()

func update_animation()->void:
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
	if velocity.y < 0:
		animation.play("jump")
	if velocity.y > 0:
		animation.play("fall")
