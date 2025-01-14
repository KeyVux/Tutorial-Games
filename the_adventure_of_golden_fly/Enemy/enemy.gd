class_name Enemy
extends CharacterBody2D

@onready var player = $/root/Node2D/Node2DPlayer
@onready var animation: AnimationPlayer = $AnimationPlayer

@export var distance: float = 10.0

var playerPosition: Vector2 = Vector2.ZERO
var targetPosition: Vector2 = Vector2.ZERO
var speed: float


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		player.onDie()
		#print("Kill!")

func jumpToPlayer(): 
	if player.isDie == true:
		return
		
	var direction = (player.global_position - global_position).normalized()
	var newPosition = global_position + direction * distance 
	var tween = get_tree().create_tween()
	
	if player.global_position.x > global_position.x:
		$Frog.flip_h = true
	else:
		$Frog.flip_h = false
	
	animation.play("run")
	speed = animation.current_animation_length
	tween.tween_property(self, "global_position", newPosition, speed)
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(func(): animation.play("idle"))
