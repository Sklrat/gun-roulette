extends Node2D

@export var lighted_image: Sprite2D
@export var noise: NoiseTexture2D

@export var min_light = 0.5
@export var max_light = 1
var light_intensity
var time_till = 0.1
var time_passed: = 0.0

func _process(delta: float) -> void:
	time_passed += delta
	var sampled_noise = noise.noise.get_noise_1d(time_passed)
	sampled_noise = abs(sampled_noise) * 2
	lighted_image.self_modulate.a = sampled_noise
	


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ThePlace.tscn")
