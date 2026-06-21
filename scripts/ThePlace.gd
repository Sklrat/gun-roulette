extends Node2D

@export var entity = preload("res://entitys/enemy.tscn")

var round: int = 0
var enemys_killed: int = 0
var guns_fired: int = 0
var game_state: String = "idle": 
	set(value): #this is so that it only sends signal when updated instead of every frame
		game_state = value
		state_changed.emit(game_state)

var entity_positions: Array[Vector2] = []
var enemys_left: int = 0
var min_distance: float  = 200
var center = Vector2(0, -100)
var radius: float = 250

signal state_changed(game_state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_entitys(5)

func spawn_entitys(amount: int) -> void: #swpan entitys, amount EXCLUES player entity
	for i in amount:
		var enemy = entity.instantiate()
		enemy.global_position = get_spawn_point()
		add_child(enemy)
	enemys_left = amount
		
func get_spawn_point() -> Vector2:
	while true:
		var angle = randf() * TAU
		var point = center + Vector2(cos(angle), sin(angle)) * radius
		
		var valid = true
		
		for existing_point in entity_positions:
			if point.distance_to(existing_point) < min_distance:
				valid = false
				break
				
		if valid:
			entity_positions.append(point)
			return point
			
	return Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
