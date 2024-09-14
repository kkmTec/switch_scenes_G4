extends Node2D

signal level_changed(level_name)

@export var level_name: String = ""

var level_parameters := {
	"clicks_p": 0,
	"test": "test",
	"energi": 200	
}

func _ready():
	#$lbl_click.text = "clicks: " + str(level_parameters.clicks_p)
	pass
#	add_click(level_parameters.clicks_p)

func load_new_parameters(new_level_parameters: Dictionary):
	level_parameters = new_level_parameters
	$lbl_click.text = "clicks: " + str(level_parameters.clicks_p)

func _on_btn_change_scene_pressed():
	print("change from scene " + level_name)
	$exit_sound.play()
	if $exit_sound.playing:
		await $exit_sound.finished
	emit_signal("level_changed", level_name)


func add_click(new_value: int):
	level_parameters.clicks_p = new_value
	$lbl_click.text = "clicks: " + str(level_parameters.clicks_p)
	

func _on_btn_click_pressed():
	add_click(level_parameters.clicks_p + 1)
