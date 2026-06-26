extends Entity


func die() -> void:
	super()
	main_scene.subtract_bullets(1)
