extends Area2D
class_name Laser

var speed = 1000


func _ready():
	var tween = create_tween()
	tween.tween_property($LaserImage, 'scale', Vector2(1,1),0.2).from(Vector2(0,0))
	
func _process(delta: float):
	position.y -= speed * delta

func onHit(meteor: Meteorite):
	queue_free()  # Delete the laser
	meteor.queue_free()  # Delete the meteor
