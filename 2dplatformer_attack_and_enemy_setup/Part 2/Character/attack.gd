extends State

@onready var timer: Timer = $Timer

@export var returnState: State
@export var returnAnimationNode: String = "move"
@export var attack1Name: String = "attack1"
@export var attack2Name: String = "attack2"
@export var attack2_node: String = "attack2"

func state_input(event: InputEvent):
	if Input.is_action_just_pressed("attack"):
		timer.start()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == attack1Name :
		if timer.is_stopped():
			next_state = returnState
			playback.travel(returnAnimationNode)
			
		else:
			playback.travel(attack2_node)
			
	if anim_name == attack2Name:
		next_state = returnState
		playback.travel(returnAnimationNode)
		
