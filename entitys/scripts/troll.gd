extends Entity

@export var timer: float = 12 #time in seconds per teleport
var time_till_teleport: float

func _ready() -> void:
	super()
	time_till_teleport = timer

func _process(delta: float) -> void:
	super(delta)
	time_till_teleport -= delta
	#slightly broken but whatever
	if time_till_teleport <= 0:
		self.global_position = main_scene.get_spawn_point()
		main_scene.entity_positions.pop_back()
		time_till_teleport = timer
	
	
