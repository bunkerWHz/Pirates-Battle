extends StaticBody2D
var activated : bool = false



func interact() -> void:
	if not activated:
		GM.world_map.show()
		activated = !activated
	else:
		GM.world_map.hide()
		activated = !activated
		
