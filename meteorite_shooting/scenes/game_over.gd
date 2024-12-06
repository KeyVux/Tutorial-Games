extends Control

@export var levelSence: PackedScene = load("res://scenes/level.tscn")

func _ready():
	$BG/GameOver/VBoxContainer/Score.text = $BG/GameOver/VBoxContainer/Score.text + str(Global.score)

func _input(event):
	if event.is_action_pressed("shoot"):
		get_tree().change_scene_to_packed(levelSence)
