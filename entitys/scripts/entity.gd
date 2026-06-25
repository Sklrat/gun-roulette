extends Node2D
class_name Entity

var heart_scene = preload("res://scenes/Heart.tscn")
@export var animation_player: AnimationPlayer
var main_scene

@export var lives: int = 3
@export var is_enemy: bool

var heart_nodes: Array[Sprite2D]
var heart_spacing_x: float = 30
var heart_spacing_y: float = 70

func loose_lives(amount: int) -> void:
	for i in amount:
		var heart = heart_nodes[-1]
		var heart_animation_player = heart.get_node("AnimationPlayer")
		heart_animation_player.play("loose_life")
		await heart_animation_player.animation_finished
		lives -= 1
		heart_nodes.erase(heart)
		heart.queue_free()
		
		if lives <= 0:
			die()
			return
			
func die() -> void:
	main_scene.enemys_left -= 1
	if animation_player != null:
		animation_player.play("die")
		await animation_player.animation_finished
	main_scene.entitys.erase(self)
	self.queue_free()
	if is_enemy:
		main_scene.enemys_killed += 1
		enemy_died.emit()
	
signal enemy_died()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_scene = get_parent()
	#generating hearts
	var start_placement = -((lives - 1) * heart_spacing_x / 2)
	for i in lives:
		var heart = heart_scene.instantiate()
		heart.position = Vector2(start_placement + i * heart_spacing_x, heart_spacing_y)
		heart_nodes.append(heart)
		add_child(heart)
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
