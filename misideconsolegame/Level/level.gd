extends Node2D
#const ENEMY_CAP: = 20

@onready var enemyScene: PackedScene = load("res://Enemy/Enemy.tscn")
@onready var coinScene: PackedScene = load("res://Coin/Coin.tscn")
@onready var coinSpawnLocation = $Node2DPlayer/Area2DCoinZone/CoinPath2D/PathFollow2D
@onready var enemySpawnLocation = $Node2DPlayer/Area2DEnemyZone/CoinPath2D/PathFollow2D

var exitedCoin = false
var enemyMax: = 1
var enemyNumber: = 0

func _process(delta: float):

	if enemyNumber < enemyMax:
		spawnEnemy()
		
	if exitedCoin == false:
		spawnCoin()
		print("Spawn")
	pass
	
	
	
#func _on_timer_timeout() -> void:
	#var enemy = enemyScene.instantiate()
	#ranX = randf_range(-1300, 1300)
	#ranY = randf_range(-1300, 1300)
	#enemy.global_position = Vector2(ranX,ranY)
	#add_child(enemy)

func spawnCoin():
	var coin = coinScene.instantiate()
	coinSpawnLocation.progress_ratio = randf()
	coin.global_position = coinSpawnLocation.global_position
	add_child(coin)	
	exitedCoin = true
	
func spawnEnemy():
	var enemy = enemyScene.instantiate()
	enemySpawnLocation.progress_ratio = randf()
	enemy.global_position = enemySpawnLocation.global_position
	add_child(enemy)
	enemyNumber += 1

func _on_area_2d_coin_zone_body_exited(body: Node2D) -> void:
	if body.name == "Node2DCoin":
		body.queue_free()
		exitedCoin = false
		
	body.queue_free()
	enemyNumber -= 1
