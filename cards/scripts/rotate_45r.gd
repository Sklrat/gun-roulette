extends Card



func _ready():
	super()

	
func _on_pressed() -> void:
	super()
	
func _on_state_changed(state: String) -> void:
	if state == "counting_down":
		_enable()
	else:
		_disable()
