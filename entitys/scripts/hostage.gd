extends Entity


func die() -> void:
	super()
	main_scene.remove_random_card(2)
