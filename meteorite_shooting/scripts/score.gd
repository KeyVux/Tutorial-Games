extends Label

class_name Score

static var instance: Score

func _ready():
	instance = self

func addScore(increment: int = 1):
	text = str(int(text) + 1)
