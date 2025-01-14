class_name HitState
extends State
@onready var timer: Timer = $Timer
@onready var character_state_machine: CharacterStateMachine = $".."

@export var damagetable: Damagetable 
@export var deadState: State 
@export var deadAnimationNode: String = "dead"
@export var knockback_speed: float = 100.0
@export var returnState: State

var knockBackDirection: Vector2

func _ready():
	damagetable.connect("onHit", onDamagetableHit)

func on_enter(): 
	timer.start()
	
func state_process(delta):
	if not character.is_on_floor():
		character.velocity += character.get_gravity() * delta
		
	character.velocity.x = move_toward(character.velocity.x, 0, 2)
	character.move_and_slide()
	
func onDamagetableHit(node: Node, damageAmount: float, knockBackDirection: Vector2):
	if damagetable.Health > 0:
		character.velocity = knockback_speed * knockBackDirection
		character_state_machine.switch_states(self)
		
		print("onDamagetableHit() velocity", character.velocity)
	else:
		character_state_machine.switch_states(deadState)
		playback.travel(deadAnimationNode)
		
func on_exit():
	#character.velocity = Vector2.ZERO
	pass


func _on_timer_timeout() -> void:
	next_state = returnState # Replace with function body.
