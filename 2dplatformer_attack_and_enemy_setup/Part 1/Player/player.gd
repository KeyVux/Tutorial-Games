extends CharacterBody2D


@export var speed: float = 300.0
@export var jumpVelocity: float = -400.0
@export var doubleJumpVelocity: float = -100.0
@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D

#get gravity from project setting
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var hasDoubleJump: bool = false
var animationLocked: bool = false
var direction: Vector2 = Vector2.ZERO
var wasInAir: bool = false

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		wasInAir = true	
	elif wasInAir == true:
		hasDoubleJump = false
		land()
		wasInAir = false

		
	if Input.is_action_just_pressed("jump") and !is_on_floor() and !hasDoubleJump:
		doubleJump()

	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
		
	direction = Input.get_vector("left", "right", "up", "down")
	
	if direction:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()
	
	updateAnimation()
	updateFacingDirection()
	
func updateAnimation():
	if animationLocked:
		return
		
	if direction.x != 0:
		animatedSprite2d.play("run")
	else:
		animatedSprite2d.play("idle")

func updateFacingDirection():
	if direction.x > 0:
		animatedSprite2d.flip_h = false
	elif direction.x < 0:
		animatedSprite2d.flip_h = true
		
func jump():
	velocity.y = jumpVelocity
	animatedSprite2d.play("jump_start")
	animationLocked = true
	
func doubleJump():
	velocity.y = doubleJumpVelocity
	animatedSprite2d.play("jump_double")
	animationLocked = true
	hasDoubleJump = true
	
func land():
	animatedSprite2d.play("jump_end")
	animationLocked = true


func _on_animated_sprite_2d_animation_finished() -> void:
	if (["jump_end", "jump_double"].has(animatedSprite2d.animation)):
		animationLocked = false
