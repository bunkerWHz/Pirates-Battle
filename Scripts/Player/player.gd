extends CharacterBody2D
class_name Player

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var hit_box: HitBox = $WeaponSlot/HitBox

@onready var collision: CollisionShape2D = $WeaponSlot/HitBox/CollisionShape2D
@onready var weapon_slot: Node2D = $WeaponSlot

@export var speed : float = 200
@export var jump_height : float = -300
@export var damage: float = 10

@export var attacking : bool = false
var max_health = 20
var current_health

var object: Area2D

var direction

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	GM.player = self
	z_index = 1
	current_health = max_health
	collision.call_deferred("set","disabled",true)

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left","right")
	if Input.is_action_just_pressed("interact") and not attacking:
		interact()
	if Input.is_action_just_pressed("left") and not attacking:
		sprite.scale.x = abs(sprite.scale.x) * -1
		weapon_slot.scale.x = abs(weapon_slot.scale.x) * -1
		
	if Input.is_action_just_pressed("right") and not attacking:
		sprite.scale.x = abs(sprite.scale.x) * 1
		weapon_slot.scale.x = abs(weapon_slot.scale.x) * 1
	if Input.is_action_just_pressed("down") and is_on_floor():
		position.y += 5
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if is_on_floor() and Input.is_action_just_pressed("jump") and not attacking:
		velocity.y = jump_height
		
	if attacking == false:
		collision.call_deferred("set","disabled",true)
		
	if velocity.x == 0 and Input.is_action_just_pressed("attack"):
		attacking = true
		collision.call_deferred("set","disabled",false)
		
	if direction: 
		velocity.x = speed * direction
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	update_animation()
	move_and_slide()

func update_animation()->void:
	if velocity.x != 0 and not attacking:
		animation.play("run")
	if velocity.x == 0 and not attacking:
		animation.play("idle")
	if velocity.x == 0 and attacking:
		animation.play("attack1")
	if velocity.y < 0:
		animation.play("jump")
	if velocity.y > 0:
		animation.play("fall")
		
func take_damage(taken_damage) -> void:
	health_component.take_damage(taken_damage)

func interact() -> void:
	if object != null:
		print(object)
		object.owner.interact()
	
func _on_interactable_area_area_entered(area: Area2D) -> void:
	if area.owner.has_method("interact"):
		object = area

func _on_interactable_area_area_exited(_area: Area2D) -> void:
	object = null

func respawn() -> void:
	if GM.current_checkpoint != null:
		position = GM.current_checkpoint.global_position
	
