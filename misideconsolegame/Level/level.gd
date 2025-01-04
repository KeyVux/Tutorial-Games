extends Node2D
#const ENEMY_CAP: = 20

@onready var enemyScene: PackedScene = load("res://Enemy/Enemy.tscn")
@onready var coinScene: PackedScene = load("res://Coin/Coin.tscn")
@onready var coinSpawnLocation: PathFollow2D = $Node2DPlayer/Area2DCoinZone/CoinPath2D/PathFollow2D
@onready var enemySpawnLocation: PathFollow2D = $Node2DPlayer/Area2DEnemyZone/CoinPath2D/PathFollow2D

var exitedCoin = false
var enemyMax: = 1
var enemyTotal: = 0

func _process(delta: float):

	if enemyTotal < enemyMax:
		spawnEntity(enemySpawnLocation, enemyScene)
		enemyTotal += 1
		
	if exitedCoin == false:
		spawnEntity(coinSpawnLocation, coinScene)
		exitedCoin = true
		#print("Spawn")
	
	
	
#func _on_timer_timeout() -> void:
	#var enemy = enemyScene.instantiate()
	#ranX = randf_range(-1300, 1300)
	#ranY = randf_range(-1300, 1300)
	#enemy.global_position = Vector2(ranX,ranY)
	#add_child(enemy)

func spawnEntity(spawnLocation: PathFollow2D, Scene: PackedScene):
	var entity = Scene.instantiate()
	spawnLocation.progress_ratio = randf()
	entity.global_position = spawnLocation.global_position
	add_child(entity)

func _on_area_2d_coin_zone_body_exited(body: Node2D) -> void:
	if body.name == "Node2DCoin":
		body.queue_free()
		exitedCoin = false
		

func _on_area_2d_enemy_zone_body_exited(body: Node2D) -> void:
	if body.name == "Node2DEnemy":
		body.queue_free()
		enemyTotal -= 1
