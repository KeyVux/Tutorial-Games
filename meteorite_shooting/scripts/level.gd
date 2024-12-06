extends Node2D


@onready var meteorTimer = $MeteorTimer

var health: int = 300

# 1. Load scenes
var meteorScenes: PackedScene = load("res://scenes/meteorite.tscn")
var laserScenes: PackedScene =  load("res://scenes/laser.tscn")

func _ready():
	meteorTimer.start()
	meteorTimer.connect("timeout", onMeteorTimer)
	
	# Get health
	get_tree().call_group('UI', 'setHealth', health)

	
	#star
	var size = get_viewport().get_visible_rect().size
	var rng = RandomNumberGenerator.new()
	
	for star in $Stars.get_children():
		# Position
		var random_y = rng.randi_range(0, size.y)
		var random_x = rng.randi_range(0, size.x)
		star.position = Vector2(random_x, random_y)
		
		# Scale
		var random_scale = rng.randf_range(1,1.3)
		star.scale = Vector2(random_scale, random_scale)
		
		# Animation scale
		star.speed_scale = rng.randf_range(0.6, 1.4)


func onMeteorTimer():
	# 2. Create instance
	var meteor = meteorScenes.instantiate()
	
	# 3. attach the node to scenes tree
	$Meteors.add_child(meteor)
	
	# Connect the signal
	meteor.connect('collision', onMeteorCollision)

func onMeteorCollision():
	#print("meteor collison in level")
	health -= 1
	#print(health)
	get_tree().call_group('UI', 'setHealth', health)
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_player_laser(pos):
	var laser = laserScenes.instantiate()
	$Lasers.add_child(laser)
	laser.global_position = pos
	#print(laser.position)
