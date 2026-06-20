extends Node2D

@export var entity = preload("res://entitys/enemy.tscn")

var entity_positions: Array[Vector2] = []
var min_distance: float  = 200
var center = Vector2.ZERO
var radius: float = 250

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
			
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in 5:
		var enemy = entity.instantiate()
		enemy.global_position = get_spawn_point()
		add_child(enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
