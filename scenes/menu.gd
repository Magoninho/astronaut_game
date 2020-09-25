extends Node2D


onready var start = $start/Selector
onready var continuar = $continue/Selector
onready var quit = $quit/Selector

var current_selector = 0
var go = false


"""load game"""

func load_game():
	var file = File.new()
	if file.file_exists(Global.save_path):
		file.open(Global.save_path, File.READ)
		var player_data = file.get_var()
		Global.current_level = player_data.level
		print(player_data.level)
		get_tree().change_scene("res://scenes/level" + str(player_data.level) + ".tscn")
		file.close()
	else:
		print("nao")

func _ready():
	get_node("guy/AnimationPlayer").play("flutua")
	change_selection()



func accept():
	$accept.play()
	$Timer.start()

func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		$selection.play()
		current_selector += 1
		change_selection()
	if Input.is_action_just_pressed("ui_up"):
		$selection.play()
		current_selector -= 1
		change_selection()
		
	""" stuff """
	if Input.is_action_just_pressed("ui_accept"):
		accept()



func change_selection():
	start.text = ""
	continuar.text = ""
	quit.text = ""
	
	
	if current_selector == 0:  # START
		start.text = "!"
		continuar.text = ""
		quit.text = ""
	elif current_selector == 1: # CONTINUE
		start.text = ""
		continuar.text = "!"
		quit.text = ""
	elif current_selector == 2:  # QUIT
		start.text = ""
		continuar.text = ""
		quit.text = "!"
		
	# Passa pro primeiro e pro último
	elif current_selector > 2:
		current_selector = 0
		start.text = "!"
		continuar.text = ""
		quit.text = ""
	elif current_selector < 0:
		current_selector = 2
		start.text = ""
		continuar.text = ""
		quit.text = "!"
# Called when the node enters the scene tree for the first time.





func _on_Timer_timeout():
	if current_selector == 0:
		get_tree().change_scene("res://scenes/level1.tscn")
	elif current_selector == 1:
		load_game()
