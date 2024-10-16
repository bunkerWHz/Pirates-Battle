extends Node

var current_checkpoint: Checkpoint




var is_paused : bool = false
var pause_menu
var map: String

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

func load_word():
	get_tree().change_scene_to_file(map)
	
func exit_game():
	get_tree().quit()
