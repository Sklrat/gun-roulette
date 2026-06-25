extends CanvasLayer

var game_manager
@export var game_over_text: Label
@export var rounds_text: Label
@export var enemys_text: Label
@export var guns_text: Label
@export var cards_text: Label
@export var menu_button: Button

var win = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_manager = get_parent()


func prepare_screen(win: bool) -> void:
	if win:
		game_over_text.text = "You Win!"
	rounds_text.text = "Round: " + str(game_manager.round)
	enemys_text.text = "Enemys Killed: " + str(game_manager.enemys_killed)
	guns_text.text = "Guns Shot: " + str(game_manager.guns_shot)
	cards_text.text = "Cards Played: " + str(game_manager.cards_played)
	self.visible = true
	
	


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
