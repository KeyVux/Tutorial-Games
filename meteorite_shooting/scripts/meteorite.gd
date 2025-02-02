extends Area2D

class_name Meteorite 

var meteorAsset: Array[Sprite2D]
var speed: int
var rotationSpeed: int
var directionX: float 
var isHit := false

signal collision

func _ready():
	var rng := RandomNumberGenerator.new()	
	
	#Start position
	var width = get_viewport().get_visible_rect().size[0]
	var random_x = rng.randi_range(0, width)
	var random_y = rng.randi_range(-150, -50)
	
	# Texture 
	var bigMeteorPath: String = "res://assets/PNG/Meteors/Big/" + str(rng.randi_range(1,4)) + ".png"
	$MeteoriteImage.texture = load(bigMeteorPath)
	
	position = Vector2(random_x, random_y)
	
	# Speed // rotation // direction
	speed = rng.randi_range(200, 500)	
	rotationSpeed = rng.randi_range(40,100)
	directionX = rng.randf_range(-1,1)
	
func _process(delta: float):
	position += Vector2(directionX,1.0) * 400 * delta
	rotation_degrees += rotationSpeed * delta

func _on_area_entered(area: Area2D) -> void:
	if !isHit && area is Laser:
		isHit = true
		Score.instance.addScore()
		area.onHit(self)
		queue_free()
		return
		



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		collision.emit()
		print("Crash!")
		queue_free()
