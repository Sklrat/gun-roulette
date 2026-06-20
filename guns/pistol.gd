extends Node2D

var acceleration: float = 0.1
var speed: float = 0
var max_speed: float = 10

var spinning: bool = false
var stop_spinning: bool = false

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
	rotation += speed * delta
	
func _shoot() -> void:
	pass
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spinning:
		_spin(delta)
	elif stop_spinning:
		_stopspin(delta)
	

func _on_spin_pressed() -> void:
	spinning = true


func _on_stop_pressed() -> void:
	spinning = false
	stop_spinning = true
