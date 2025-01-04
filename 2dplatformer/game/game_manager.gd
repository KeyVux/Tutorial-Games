extends Node

@onready var scoreLabel: Label = $ScoreLabel

var score = 0

func addPoin():
	score += 1
	scoreLabel.text = "You collected " + str(score) + " coins"
	print(score)
