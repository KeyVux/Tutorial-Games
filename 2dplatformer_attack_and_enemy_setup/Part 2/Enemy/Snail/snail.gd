extends CharacterBody2D

@onready var animationTree: AnimationTree = $AnimationTree
@onready var stateMachine: CharacterStateMachine = $CharacterStateMachine
@onready var damagetable: Damagetable = $Damagetable


@export var hitState: State
@export var movementSpeed: float = 30.0
@export var startingMoveDirection: Vector2 = Vector2.LEFT



func _ready():
	animationTree.active = true
	
func _physics_process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	damagetable.hit(0, Vector2(1, -1))
