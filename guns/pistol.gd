extends Node2D

@export var collision_shape: CollisionShape2D
var main_scene

var damage: int = 1

var acceleration: float = 0.1
var speed: float = 0
var max_speed: float = 10

var spinning: bool = false
var stop_spinning: bool = false

var countdown_timer: float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_scene = get_parent()
	collision_shape.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spinning:
		spin(delta)
	elif stop_spinning:
		stopspin(delta)
	elif main_scene.game_state == "counting_down":
		start_countdown(delta)
		
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
		main_scene.game_state = "counting_down"
		
	rotation += speed * delta
	
func start_countdown(delta:float) -> void:
	countdown_timer -= delta
	if countdown_timer <= 0:
		countdown_timer = 0
		shoot()
	#print(countdown_timer)
	
func shoot() -> void:
	collision_shape.disabled = false
	
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
