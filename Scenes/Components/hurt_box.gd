class_name HurtBox
extends Area2D

signal received_damage(damage: float)

func _ready() -> void:
	monitorable = false
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	if hitbox != null:
		owner.take_damage(hitbox.damage)
		received_damage.emit(hitbox.damage)
