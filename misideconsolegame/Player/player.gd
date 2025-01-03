extends CharacterBody2D

@export var speed: int
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta: float):
	var directionTemp = Input.get_vector("left", "right", "up", "down")
	
	if directionTemp != Vector2.ZERO:
		direction = directionTemp
		
	velocity = direction * speed 
	move_and_slide()
	
	#body.position += transform.x * speed * delta
	
