extends Area2D

@export var damage: float = 10.0

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	for child in body.get_children():
		if child is Damagetable:
			child.hit(damage)
