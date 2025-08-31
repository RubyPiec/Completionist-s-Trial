extends Camera2D


func _on_player_out_of_view(pos) -> void:
	position.x=floor((pos.x+1152)/1152)*1152-576
	position.y=floor((pos.y+648)/648)*648-324
	pass # Replace with function body.
