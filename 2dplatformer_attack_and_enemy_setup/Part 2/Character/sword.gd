extends Area2D

@export var damage: float = 0.0
@export var player: Player
@export var facingCollisionShape2d: FacingCollisionShape2D

func _ready() -> void:
	player.connect("facingDirectionChanged", onPlayerFacingDirectionChanged)

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	for child in body.get_children():
		if child is Damagetable:
			var directionToDamageable = body.global_position - get_parent().global_position
			var directionSign = sign(directionToDamageable.x)
			
			if directionSign > 0:
				child.hit(damage, Vector2.RIGHT)
			elif directionSign < 0:
				child.hit(damage, Vector2.LEFT)
			else:
				child.hit(damage, Vector2.ZERO)

func onPlayerFacingDirectionChanged(facingRight: bool):
	if facingRight:
		facingCollisionShape2d.position = facingCollisionShape2d.facingRightPosition
	else:
		facingCollisionShape2d.position = facingCollisionShape2d.facingLeftPosition
