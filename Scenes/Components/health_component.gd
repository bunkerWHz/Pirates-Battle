extends Control
class_name HealthComponent

@onready var damage: float = owner.taken_damage
@export var damage_label : bool = true

func show_damage_label(damage: float) -> void:
	if damage_label:
		var damage_label: Label = _create_indicator_label(damage)
		add_child(damage_label)
		_do_label_tween(damage_label, position + Vector2(100, -30))
	
func _create_indicator_label(damage)-> Label:
	var new_label = Label.new()
	new_label.text = str(damage)
	new_label.position += Vector2(40, 0)
	new_label.add_theme_color_override("font_color", _get_label_color(damage))
	new_label.add_theme_font_size_override("font_size", 30)
	return new_label
	
func _get_label_color(damage: float)-> Color:
	if damage > 0: return Color(0, 1, 0, 0.9)
	elif damage < 0: return Color(1, 0, 0, 0.9)
	else: return Color(0.5, 0.5, 0.5, 0.9)
	
func _do_label_tween(label, endPosition):
	var duration = 1
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position", endPosition, duration)
	await get_tree().create_timer(duration).timeout
	label.queue_free()
