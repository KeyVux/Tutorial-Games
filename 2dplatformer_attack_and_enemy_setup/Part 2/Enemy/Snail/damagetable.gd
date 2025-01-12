class_name Damagetable
extends Node

@export var health: float = 20.0

func hit(damage: float):
	health -= damage
	
	if health <= 0:
		get_parent().queue_free()
