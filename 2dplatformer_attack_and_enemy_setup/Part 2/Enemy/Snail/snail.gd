extends CharacterBody2D

@onready var animationTree: AnimationTree = $AnimationTree
@onready var stateMachine: CharacterStateMachine = $CharacterStateMachine

@export var hitState: State
@export var movementSpeed: float = 30.0
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
	if direction && stateMachine.check_if_can_move():
		velocity.x = direction.x * movementSpeed
	elif stateMachine.current_state != hitState:
		velocity.x = move_toward(velocity.x, 0, movementSpeed)

	move_and_slide()
