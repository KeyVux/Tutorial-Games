extends CharacterBody2D

@onready var animationTree: AnimationTree = $AnimationTree

@export var startingMoveDirection: Vector2 = Vector2.LEFT
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	animationTree.active = true
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction: Vector2 = startingMoveDirection
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
