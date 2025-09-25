extends Area2D
var clicks = 0

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Achievements.getAch("clicker")
		clicks+=1
		if clicks==5:
			Achievements.getAch("stop")
