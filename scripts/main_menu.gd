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
	print(sampled_noise)
	#time_till -= delta
	#if time_till:
		#light_intensity = randf_range(min_light,max_light)
		#lighted_image.self_modulate.a = light_intensity
		#time_till = 0.4
	
