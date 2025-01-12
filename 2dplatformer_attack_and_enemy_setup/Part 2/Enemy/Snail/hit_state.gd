class_name HitState
extends State
@onready var timer: Timer = $Timer

@export var damagetable: Damagetable 
@export var deadState: State 
@export var deadAnimationNode: String = "dead"
@export var knockback_velocity: Vector2 = Vector2(100, 0)
@export var returnState: State

func _ready():
	damagetable.connect("onHit", onDamagetableHit)

func on_enter():
	character.velocity = knockback_velocity
	timer.start()
	
func onDamagetableHit(node: Node, damageAmount: float):
	if damagetable.Health > 0:
		emit_signal("interruptState", self)
	else:
		emit_signal("interruptState", deadState)
		playback.travel(deadAnimationNode)
		
func onExit():
	character.velocity = Vector2.ZERO


func _on_timer_timeout() -> void:
	next_state = returnState # Replace with function body.
