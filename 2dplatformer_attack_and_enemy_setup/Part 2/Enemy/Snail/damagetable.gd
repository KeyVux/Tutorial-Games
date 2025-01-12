class_name Damagetable
extends Node

signal onHit(node: Node, damageTaken: float, knockBackDirection: Vector2)


@export var deadAnimationName: String = "dead"
@export var Health: float = 20.0:
	get:
		return Health
	set(value):
		SignalBus.emit_signal("onHealthChange", get_parent(), value - Health)
		Health = value

func hit(damage: float, knockBackDirection: Vector2):
	Health -= damage
	
	emit_signal("onHit",get_parent(), damage, knockBackDirection)
	


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == deadAnimationName:
		get_parent().queue_free()
		
