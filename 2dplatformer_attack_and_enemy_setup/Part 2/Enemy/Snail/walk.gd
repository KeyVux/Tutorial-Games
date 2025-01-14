extends State

@onready var snail: CharacterBody2D = $"../.."
@onready var stateMachine: CharacterStateMachine = $".."
@export var hitState: State


@export var startingMoveDirection: Vector2 = Vector2.LEFT
@export var movementSpeed: float = 30.0

func state_process(delta):
	# Add the gravity.
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta

	var direction: Vector2 = startingMoveDirection
	if direction && stateMachine.check_if_can_move():
		character.velocity.x = direction.x * movementSpeed
	elif stateMachine.current_state != hitState:
		character.velocity.x = move_toward(character.velocity.x, 0, movementSpeed)
	
	print("character.velocity", character.velocity)
	character.move_and_slide()
