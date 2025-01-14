extends Area2D

@onready var player = $/root/Node2D/Node2DPlayer

func _process(delta: float) -> void:
	if player.isDie == true:
		$Sprite2D.stop()

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		queue_free()
		player.ExitedCoin = false
		player.onCoin()
		#print("Scored!")
