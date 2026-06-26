extends CheckButton



func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		# Switch to Fullscreen
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		# Switch to Windowed
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
