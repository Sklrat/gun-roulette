extends Node2D

@export var collision_shape: CollisionShape2D

var acceleration: float = 0.1
var speed: float = 0
var max_speed: float = 10

var spinning: bool = false
var stop_spinning: bool = false

var countdown: bool = false
var countdown_timer: float = 5

func _spin(delta: float) -> void:
	if speed < max_speed:
		speed += acceleration
	rotation += speed * delta
	
func _stopspin(delta: float) -> void:
	if speed > 0:
		speed -= acceleration
	else:
		speed = 0
		stop_spinning = false
		countdown = true
		
	rotation += speed * delta
	
func _countdown(delta:float) -> void:
	countdown_timer -= delta
	if countdown_timer <= 0:
		countdown_timer = 0
		countdown = false
		_shoot()
	print(countdown_timer)
	
func _shoot() -> void:
	collision_shape.disabled = false
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision_shape.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spinning:
		_spin(delta)
	elif stop_spinning:
		_stopspin(delta)
	elif countdown:
		_countdown(delta)
		
	

func _on_spin_pressed() -> void:
	spinning = true


func _on_stop_pressed() -> void:
	spinning = false
	stop_spinning = true



func _on_area_2d_area_entered(area: Area2D) -> void:
	print("touching")
