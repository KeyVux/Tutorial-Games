extends CharacterBody2D

@export var speed: int = 500

const shoot_delay = 0.01
const LASER_POOL_MAX = 150

var shoot_timer = 0.0
var laserScene: PackedScene =  load("res://scenes/laser.tscn")
var laserPool: Array[Node] = []
var laserPoolIndex := 0

#func _ready():
	#print(position)
	
# Outside of screen
# Timer
# Object pooling (Pool) On demand
# Object pooling (Pool) Prepared

func _process(_delta: float):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# shoot input
	shoot(_delta)
	
func shoot(_delta: float):
	shoot_timer = shoot_timer - _delta
		
	if Input.is_action_pressed("shoot") and shoot_timer <= 0:
		shoot_timer = shoot_delay
		spawnLaser()
		
		
func spawnLaser():
	if laserPool.size() < LASER_POOL_MAX:
		var laser = laserScene.instantiate()
		$"../../Lasers".add_child(laser)
		laser.global_position = $LaserStartingPosition.global_position
		laserPool.append(laser)
		$"Debug Control/Label Bullet Count".text = "Bullet Spawn: %d" % laserPool.size()
		return
	$"Debug Control/Label Bullet Count".text = "Bullet Index: %d" % laserPoolIndex
	laserPool[laserPoolIndex].global_position = $LaserStartingPosition.global_position
	laserPoolIndex = (laserPoolIndex + 1) % LASER_POOL_MAX
