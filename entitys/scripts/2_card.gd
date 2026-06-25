extends Entity

func die() -> void:
	super()
	main_scene.give_random_card(2)
