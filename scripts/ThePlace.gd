extends Node2D

@export var entity = preload("res://entitys/enemy.tscn")
@export var gun: Node2D
@export var card_hbox: HBoxContainer
@export var countdown_text:Label
@export var card = preload("res://cards/buttons/rotate_45r.tscn")

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

var countdown_timer: float = 0

signal state_changed(game_state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_entitys(5)
	give_random_card(1)

func _process(delta: float) -> void:
	if game_state == "counting_down":
		countdown(delta)

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

func give_random_card(amount: int) -> void:
	for i in amount:
		var card = card.instantiate()
		card.card_pressed.connect(_on_card_pressed)
		card_hbox.add_child(card)
		
func start_countdown() -> void:
	countdown_timer = 5
	game_state = "counting_down"
	
func countdown(delta:float) -> void:
	countdown_timer -= delta
	countdown_text.text = str(snappedf(countdown_timer, 0.01))
	if countdown_timer <= 0:
		countdown_timer = 0
		gun.shoot()
	print(countdown_timer)
		
## handle card stuff
func _on_card_pressed (action: String, amount: int) -> void:
	if action == "rotate":
		gun.set_rotate_angle(amount)
		
