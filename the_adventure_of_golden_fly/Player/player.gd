class_name Player
extends CharacterBody2D

@export var speed: float = 50

@onready var background: Sprite2D = $Parallax2D/Background
@onready var root: Node2D = $".."
@onready var coinSpawnLocation: PathFollow2D = $Area2DCoinZone/CoinPath2D/PathFollow2D
@onready var enemySpawnLocation: PathFollow2D = $Area2DEnemyZone/CoinPath2D/PathFollow2D
@onready var enemyScene: PackedScene = load("res://Enemy/Enemy.tscn")
@onready var coinScene: PackedScene = load("res://Coin/Coin.tscn")
@onready var sprite: Node2D = $sprite
@onready var scoreLabel: Label = $Label
@onready var engameLabel: Label = $Control/Button/Label2

const ENEMY_CAP: = 20

var enemyMax: = 1
var enemyTotal: = 0
var direction: Vector2 = Vector2.ZERO
var isDie: = false
var score: = 0

var ExitedCoin: bool = false:
	set(value):
		ExitedCoin = value
	get:
		return ExitedCoin

#func _ready() -> void:
	#Engine.time_scale = 0.5

func _process(delta: float):
	handleBackgroundScrolling()
	handlePlayerInput()
	
	if isDie == true and Input.is_action_just_pressed("continue"):
		Engine.time_scale = 1
		get_tree().reload_current_scene()
	
	if isDie == true:
		return
	
	if enemyTotal < enemyMax:
		handleSpawnEntity(enemySpawnLocation, enemyScene)
		enemyTotal += 1
		
	if ExitedCoin == false:
		handleSpawnEntity(coinSpawnLocation, coinScene)
		ExitedCoin = true
		#print("Spawn")
	
func handlePlayerInput():
	if isDie == true:
		return
		
	var directionTemp = Input.get_vector("left", "right", "up", "down")
	
	if directionTemp != Vector2.ZERO:
		direction = directionTemp
		
	velocity = direction * speed 
	move_and_slide()
	#body.position += transform.x * speed * delta

func handleBackgroundScrolling():
	background.region_rect.position = position
	#$"../CanvasLayer/Blueconsole".position = position

func handleSpawnEntity(spawnLocation: PathFollow2D, Scene: PackedScene):
	var entity = Scene.instantiate()
	spawnLocation.progress_ratio = randf()
	entity.global_position = spawnLocation.global_position
	
	root.add_child(entity)
	
func onDie():
	$sprite/Player.hide()
	velocity = Vector2.ZERO
	direction = Vector2.ZERO
	isDie = true
	
	engameLabel.text = "SCORE: " + str(score) + "\nRESTART?"
	$Control.show()
	

func onCoin():
	score += 1
	scoreLabel.text = "SCORE: " + str(score)

func _on_timer_timeout() -> void:
	if enemyMax < ENEMY_CAP:
		enemyMax += 1;
		#Engine.time_scale += 0.3 # TODO Uncomment me


func _on_area_2d_coin_zone_area_exited(area: Area2D) -> void:
	#print("Coin leave")
	if area.name == "Node2DCoin":
		area.queue_free()
		ExitedCoin = false


func _on_area_2d_enemy_zone_body_exited(body: Node2D) -> void:
	#print("Enemy leave")
	if body.name == "Node2DEnemy":
		body.queue_free()
		enemyTotal -= 1


func _on_button_button_down() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
