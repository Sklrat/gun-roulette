extends Node2D

@export var collision_shape: CollisionShape2D
@export var animation_player: AnimationPlayer

var main_scene

var damage: int = 1

@export var max_speed: float = 10
@export var acceleration: float = 0.2
var speed: float = 0

var spinning: bool = false
var stop_spinning: bool = false

var countdown_timer: float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_scene = get_parent()
	collision_shape.disabled = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#game states
	if spinning:
		spin(delta)
	elif stop_spinning:
		stopspin(delta)

	elif main_scene.game_state == "rotation_card": #this is for when the rotation card is played
		rotate_angle(rotation_target)
		
func spin(delta: float) -> void:
	if speed < max_speed:
		speed += acceleration
		main_scene.game_state = "speeding_up"
	else:
		main_scene.game_state = "spinning"
	rotation += speed * delta
	
func stopspin(delta: float) -> void:
	if speed > 0:
		speed -= acceleration
		main_scene.game_state = "slowing_down"
		print(get_parent().game_state)
	else:
		speed = 0
		stop_spinning = false
		main_scene.start_countdown()
		
	rotation += speed * delta
	
func start_countdown(delta:float) -> void:
	countdown_timer -= delta
	if countdown_timer <= 0:
		countdown_timer = 0
		shoot()
	#print(countdown_timer)
	
	#ight now this function shoots > deswpans, and spwans a new gun
func shoot() -> void:
	main_scene.game_state = "shooting"
	animation_player.play("shoot")
	await animation_player.animation_finished
	main_scene.guns_shot += 1
	await get_tree().create_timer(1.0).timeout
	
	
	animation_player.play("despawn")
	await animation_player.animation_finished
	self.queue_free()
	
	main_scene.missed_in_row += 1
	if main_scene.missed_in_row >= 3:
		main_scene.give_random_rotation_card()
		main_scene.missed_in_row = 0
		
	main_scene.spawn_gun()
	#collision_shape.disabled = false

var rotation_progress = 0
var rotation_speed = 2
var rotation_target

## rotation card function
func rotate_angle(rotation_target: int) -> void: #in degrees
	if rotation_target > 0:
		rotation_degrees += rotation_speed
		rotation_progress += rotation_speed
		if rotation_progress >= rotation_target:
			main_scene.game_state = "counting_down"
			rotation_progress = 0
	if rotation_target < 0:
		rotation_degrees -= rotation_speed
		rotation_progress -= rotation_speed
		if rotation_progress <= rotation_target:
			main_scene.game_state = "counting_down"
			rotation_progress = 0
			

func set_rotate_angle(degrees: float) -> void:
	main_scene.game_state = "rotation_card" 
	#rotation_target = rotation_degrees + degrees
	rotation_target = degrees


# godot signals
func _on_spin_pressed() -> void:
	if main_scene.game_state == "idle":
		spinning = true
	if main_scene.game_state == "spinning":
		spinning = false
		stop_spinning = true
	

func _on_stop_pressed() -> void:
	spinning = false
	stop_spinning = true

#makes eneity take damage
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("loose_lives"):
		area.get_parent().loose_lives(damage)
		main_scene.missed_in_row = 0
