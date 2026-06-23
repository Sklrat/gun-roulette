extends Node2D

@export var entity = preload("res://entitys/enemy.tscn")
@export var gun_scene = preload("res://guns/Pistol.tscn")
@export var card_hbox: HBoxContainer
@export var countdown_text: Label
@export var round_text: Label
var card_folder = "res://cards/buttons/"
var gun
var card_files: Array[String] = []
var rotation_card_files: Array[String] = []

var round: int = 1
var enemys_killed: int = 0
var guns_fired: int = 0

var missed_in_row: int = 0
var game_state: String = "idle": 
	set(value): #this is so that it only sends signal when updated instead of every frame
		game_state = value
		state_changed.emit(game_state)

var entity_positions: Array[Vector2] = []
var enemys_left: int = 0
var min_distance: float  = 200
var center = Vector2(0, -100)
var radius: float = 200

var countdown_timer: float = 0

signal state_changed(game_state)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_cards()
	spawn_entitys(3)
	spawn_gun()
	give_random_card(8)

func _process(delta: float) -> void:
	if game_state == "counting_down":
		countdown(delta)
		
func spawn_gun() -> void:
	gun = gun_scene.instantiate()
	gun.global_position = center
	add_child(gun)
	var gun_animation_player = gun.find_child("AnimationPlayer")
	gun_animation_player.play("spawn")
	await gun_animation_player.animation_finished
	game_state = "idle"
	
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
		var random_card = card_files[randi_range(0,card_files.size() - 1)]
		var full_path = card_folder + random_card
		var card_scene = load(str(full_path))
		var card = card_scene.instantiate()
		card.card_pressed.connect(_on_card_pressed)
		card_hbox.add_child(card)
		
func give_random_rotation_card() -> void:
	var random_card = rotation_card_files[randi_range(0,rotation_card_files.size() - 1)]
	var full_path = card_folder + random_card
	var card_scene = load(str(full_path))
	var card = card_scene.instantiate()
	card.card_pressed.connect(_on_card_pressed)
	card_hbox.add_child(card)
		
func load_cards() -> void:
	var card_dir = DirAccess.open(card_folder)
	
	card_dir.list_dir_begin()
	var card_name = card_dir.get_next()
	
	while card_name != "":
		if card_name.contains("rotate"):
			rotation_card_files.append(card_name)
		card_files.append(card_name)
		card_name = card_dir.get_next()
		
	card_dir.list_dir_end()
		
func start_countdown() -> void:
	countdown_timer = 5
	game_state = "counting_down"
	gun.line2D.visible = true
	
func countdown(delta:float) -> void:
	countdown_timer -= delta
	if countdown_timer <= 0:
		countdown_timer = 0
		gun.shoot()
	countdown_text.text = str(snappedf(countdown_timer, 0.01))
		
## handle card stuff
func _on_card_pressed (action: String, amount: float) -> void:
	if action == "rotate":
		gun.set_rotate_angle(amount)
	elif action == "multiply_damage":
		gun.damage *= int(amount)
	elif action == "set_damage":
		gun.damage = int(amount)
	elif action == "slow_gun":
		gun.max_speed *= amount
		gun.speed = gun.max_speed
	elif action == "stop_gun":
		gun.spinning = false
		gun.stop_spinning = true
		gun.speed = 0
		start_countdown()
		


func _on_spin_pressed() -> void:
	gun._on_spin_pressed()
