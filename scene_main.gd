extends Node2D

@onready var current_level = $scene_one

func _init():
	print("main_init")

func _ready():
	print("main_ready")
	#queue free all scenes except the first scene
	$scene_two.queue_free()
	current_level.connect("level_changed", Callable(self, "handle_level_changed"))


func handle_level_changed(current_level_name: String):
	var next_level
	print(current_level_name + " handle")
	match current_level_name:
		"one":
			next_level = load("res://scene_two.tscn").instantiate()
		"two":
			next_level = load("res://scene_one.tscn").instantiate()
		_:
			return

	
	add_child(next_level)
	next_level.connect("level_changed", Callable(self, "handle_level_changed"))
	transfer_data_between_scenes(current_level, next_level)
	current_level.queue_free()
	current_level = next_level

	
func transfer_data_between_scenes(old_scene, new_scene):
	new_scene.load_new_parameters(old_scene.level_parameters)		
