extends TextureButton
class_name Card

@export var action_type: String
@export var value: float
@export var active_states: Array[String] 

var main_scene

var normal_color = Color(0.9,0.9,0.9)
var hover_color = Color(1,1,1)
var disabled_color = Color(0.5, 0.5, 0.5)

signal card_pressed(action_type, value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_scene = get_parent().get_parent().get_parent().get_parent() # ioefsdlkmfkjlfdskmn
	
	if main_scene and main_scene.has_signal("state_changed"):
		main_scene.state_changed.connect(_on_state_changed)
		
	_on_state_changed(main_scene.game_state)
	

func destory_card() -> void:
	main_scene.cards_played += 1
	self.queue_free()
	

func _disable() -> void:
	self.disabled = true
	self_modulate = disabled_color
	
func _enable() -> void:
	self.disabled = false
	self_modulate = normal_color
	
func _on_state_changed(state: String) ->void:
	if active_states.has(state) or active_states.has("all"):
		_enable()
	else:
		_disable()

func _on_pressed() -> void:
	card_pressed.emit(action_type, value)
	destory_card()
	
#UI color changes
func _on_mouse_entered() -> void:
	if not self.disabled:
		self_modulate = hover_color


func _on_mouse_exited() -> void:
	if not self.disabled:
		self_modulate = normal_color
		

	
