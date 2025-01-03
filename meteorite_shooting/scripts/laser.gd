extends Area2D
class_name Laser

var speed = 1000

func _ready():
	var tween = create_tween()
	tween.tween_property($LaserImage, 'scale', Vector2(1,1),0.2).from(Vector2(0,0))
	
func _process(delta: float):
	position.y -= speed * delta
	pass

func onHit(other: Node):
	#queue_free()  # Delete the laser
	
	if other is Meteorite:
		visible = false


func _on_body_entered(body: Node2D) -> void:
	print("Lazer2._on_body_entered ", body.name )
