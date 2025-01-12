class_name HitState
extends State

@export var damagetable: Damagetable 
@export var deadState: State 
@export var deadAnimationNode: String = "dead"

func _ready():
	damagetable.connect("onHit", onDamagetableHit)
	
func onDamagetableHit(node: Node, damageAmount: float):
	if damagetable.Health > 0:
		emit_signal("interruptState", self)
	else:
		emit_signal("interruptState", deadState)
		playback.travel(deadAnimationNode)
