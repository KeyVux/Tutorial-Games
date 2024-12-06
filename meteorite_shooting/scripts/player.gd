extends CharacterBody2D

@export var speed: int = 500

signal laser(pos)

var canShoot: bool = true

#func _ready():
	#print(position)

func _process(_delta: float):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# shoot input
	if Input.is_action_just_pressed("shoot") and canShoot:
		#print(position)
		laser.emit($LaserStartingPosition.global_position)
		canShoot = false
		$LaserCooldown.start()

func _on_laser_cooldown_timeout() -> void:
	canShoot = true # Replace with function body.
