extends TextureRect
var level = {
	"base" : preload("res://Scenes/WorldScenes/base_camp.tscn").instantiate(),
	"level1" : preload("res://Scenes/WorldScenes/level1.tscn").instantiate(),
}

func _on_area_2d_mouse_entered() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		hide()
		GM.world.remove_child(GM.current_scene)
		GM.current_scene = level["level1"]
		GM.load_world()

func _on_lake_mouse_entered() -> void:
	pass # Replace with function body.

func _on_forest_mouse_entered() -> void:
	pass # Replace with function body.
