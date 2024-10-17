extends Node

var current_checkpoint: Checkpoint

var world
var is_paused : bool = false
var pause_menu
var player
var world_map
var current_scene = preload("res://Scenes/WorldScenes/base_camp.tscn").instantiate()

func pause_unpause():
	is_paused = !is_paused
	if is_paused:
		pause_menu.show()
	else:
		pause_menu.hide()

func resume(): 
	get_tree().paused = false
	pause_unpause()
	
func restart():
	get_tree().reload_current_scene()
	get_tree().paused = false

func load_world():
	GM.world.add_child(current_scene)

func exit_game():
	get_tree().quit()
