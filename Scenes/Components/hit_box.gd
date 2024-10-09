class_name HitBox
extends Area2D

@onready var damage: float = owner.damage

func _ready() -> void:
	monitoring = false

func set_damage(value: float) -> void:
	damage = value
	
func get_damage() -> float:
	return damage
