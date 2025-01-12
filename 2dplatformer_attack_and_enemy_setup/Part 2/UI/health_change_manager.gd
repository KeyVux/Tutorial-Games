extends Control

@export var healChangeLabel: PackedScene
@export var damageColor: Color = Color.DARK_RED	
@export var healthColor: Color = Color.DARK_KHAKI	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.connect("onHealthChange", onSignalHealthChange)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func onSignalHealthChange(node: Node, amountChanged: float):
	var labelInstance: Label = healChangeLabel.instantiate()
	node.add_child(labelInstance)
	labelInstance.text = str(amountChanged)
	
	if amountChanged >= 0:
		labelInstance.modulate = healthColor
	else:
		labelInstance.modulate = damageColor
		
