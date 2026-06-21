extends Card



func _ready():
	super()

	
func _on_pressed() -> void:
	super._destory_card()
	
func _on_state_changed(state: String) -> void:
	if state == "counting_down":
		_enable()
	else:
		_disable()
