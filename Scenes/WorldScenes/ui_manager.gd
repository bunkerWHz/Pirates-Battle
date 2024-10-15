extends CanvasLayer

@onready var pause_menu: ColorRect = $PauseMenu

func _ready() -> void:
	pause_menu.hide()
	GM.pause_menu = pause_menu
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		GM.pause_unpause()
		get_tree().paused = GM.is_paused
		
func _on_resume_btn_pressed() -> void:
	GM.resume()


func _on_restart_btn_pressed() -> void:
	GM.restart()


func _on_world_map_btn_pressed() -> void:
	GM.load_word()


func _on_exit_game_btn_pressed() -> void:
	GM.exit_game()
