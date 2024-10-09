extends Node2D

var damage = 1
var max_health = 3

@onready var health_component: HealthComponent = $HealthComponent


func take_damage(taken_damage) -> void:
	health_component.take_damage(taken_damage)
