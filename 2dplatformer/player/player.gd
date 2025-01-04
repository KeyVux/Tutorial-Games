extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animatedSprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animatedSprite.flip_h = false
	elif direction < 0:
		animatedSprite.flip_h = true
	
	if direction == 0:
		animatedSprite.play("idle")
	else:
		animatedSprite.play("run")
	if not is_on_floor():
		animatedSprite.play("jump")
		velocity += get_gravity() * delta
		
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
