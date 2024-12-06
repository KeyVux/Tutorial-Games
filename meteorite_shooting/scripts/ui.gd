extends CanvasLayer
static var image = load("res://assets/PNG/UI/playerLife1_red.png")
var timeElapsed: int = 0

func _ready():
	$ScoreTimer.start()

func setHealth(amount):
	# Remove all children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	# Create amount is set by health
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP 
	#print(amount)
	#print('UI')


func _on_score_timer_timeout():
	timeElapsed += 1;
	$MarginContainer/Score.text = str(timeElapsed)
	#print(timeElapsed)
	Global.score = timeElapsed
