extends ProgressBar
class_name HealthComponent

@onready var damage: float = owner.damage

@onready var max_health : float = owner.max_health
var current_health

@export var damage_health_label : bool = true

func _ready() -> void:
	current_health = owner.max_health
	max_value = max_health
	value = current_health
	step = 1
	show_percentage = false
	size.x = 40
	size.y = 6
	position.x = -20
	position.y = -30
	
func show_damage_label(taken_damage) -> void:
	if damage_health_label:
		var damage_label: Label = _create_indicator_label(taken_damage)
		add_child(damage_label)
		_do_label_tween(damage_label, position + Vector2(100, -30))
	
func _create_indicator_label(taken_damage)-> Label:
	var new_label = Label.new()
	new_label.text = str(taken_damage)
	new_label.position += Vector2(40, 0)
	new_label.add_theme_color_override("font_color", _get_label_color(taken_damage))
	new_label.add_theme_font_size_override("font_size", 30)
	return new_label
	
func _get_label_color(taken_damage)-> Color:
	if taken_damage > 0: return Color(0, 1, 0, 0.9)
	elif taken_damage < 0: return Color(1, 0, 0, 0.9)
	else: return Color(0.5, 0.5, 0.5, 0.9)
	
func _do_label_tween(label, endPosition):
	var duration = 1
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position", endPosition, duration)
	await get_tree().create_timer(duration).timeout
	label.queue_free()

func update_health(new_value):
	current_health = new_value
	value = current_health
	
