extends Node


const CLICK_SOUND = preload("res://sfx/Tick.mp3")
const HOVER_SOUND = preload("res://sfx/denielcz-immersivecontrol-button-click-sound-463065.mp3")

func _ready() -> void:
	get_tree().node_added.connect(_on_node_added)

func _on_node_added(node: Node) -> void:
	# BaseButton covers Button, TextureButton, CheckBox, etc.
	if node is BaseButton and not node.is_in_group("silent_button"):
		node.pressed.connect(_play_click_sound)
		node.mouse_entered.connect(_on_button_hover.bind(node))
		
func _on_button_hover(node: BaseButton) -> void:
	if not node.disabled:
		_play_hover_sound()
		
func _play_click_sound() -> void:
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = CLICK_SOUND
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.play()

func _play_hover_sound() -> void:
	var audio_player = AudioStreamPlayer.new()
	add_child(audio_player)
	audio_player.stream = HOVER_SOUND
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.play()
