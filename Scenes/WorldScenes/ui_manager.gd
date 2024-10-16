extends CanvasLayer

@onready var pause_menu: ColorRect = $PauseMenu
var index : int = 0
func _ready() -> void:
	pause_menu.hide()
	GM.pause_menu = pause_menu
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		GM.pause_unpause()
		get_tree().paused = GM.is_paused
		
	if pause_menu.visible == true:
		pause_menu.get_child(0).get_child(index).get_child(0).grab_focus()
		if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("ui_down"):
			set_index(1)
		if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("ui_up"):
			set_index(-1)
			
func set_index(value):
	if index == 0:
		if value > 0:
			index += value
		else:
			index = pause_menu.get_child(0).get_children().size() - 1
	elif index == pause_menu.get_child(0).get_children().size() - 1:
		if value > 0:
			index = 0
		else:
			index += value
	else:
		index += value
		  
func _on_resume_btn_pressed() -> void:
	GM.resume()

func _on_restart_btn_pressed() -> void:
	GM.restart()

func _on_world_map_btn_pressed() -> void:
	GM.load_word()

func _on_exit_game_btn_pressed() -> void:
	GM.exit_game()
