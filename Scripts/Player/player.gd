extends CharacterBody2D
class_name Player

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hit_box: HitBox = $HitBox

@export var speed : float = 200
@export var jump_height : float = -300
@export var damage: float = 10

var max_health = 20
var current_health

var object: Area2D

var direction
		
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	current_health = max_health

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left","right")
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_just_pressed("left"):
		sprite.scale.x = abs(sprite.scale.x) * -1
		hit_box.position.x = abs(hit_box.position.x) * -1
	if Input.is_action_just_pressed("right"):
		sprite.scale.x = abs(sprite.scale.x) * 1
		hit_box.position.x = abs(hit_box.position.x) * 1
	if Input.is_action_just_pressed("down") and is_on_floor():
		position.y += 5
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
		
func take_damage(taken_damage) -> void:
	health_component.take_damage(taken_damage)

#func _on_hurt_box_area_entered(_area: Area2D) -> void:
	#pass

func interact() -> void:
	if object != null:
		object.owner.interact()
	
func _on_interactable_area_area_entered(area: Area2D) -> void:
	if area.owner.has_method("interact"):
		object = area

func _on_interactable_area_area_exited(_area: Area2D) -> void:
	object = null

func respawn() -> void:
	if GM.current_checkpoint != null:
		position = GM.current_checkpoint.global_position
	
