@abstract
extends TextureButton
class_name Card

var main_scene

var normal_color = Color(0.9,0.9,0.9)
var hover_color = Color(1,1,1)
var disabled_color = Color(0.5, 0.5, 0.5)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_scene = get_parent().get_parent().get_parent().get_parent() # ioefsdlkmfkjlfdskmn
	
	if main_scene and main_scene.has_signal("state_changed"):
		main_scene.state_changed.connect(_on_state_changed)
		
	_on_state_changed(main_scene.game_state)
	
@abstract
func _on_state_changed(state: String)

func _destory_card() -> void:
	self.queue_free()

func _disable() -> void:
	self.disabled = true
	self_modulate = disabled_color
	
func _enable() -> void:
	self.disabled = false
	self_modulate = normal_color
	
#UI color changes
func _on_mouse_entered() -> void:
	if not self.disabled:
		self_modulate = hover_color


func _on_mouse_exited() -> void:
	if not self.disabled:
		self_modulate = normal_color
		

	
