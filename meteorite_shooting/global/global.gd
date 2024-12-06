extends Node

var score := 0

func addScore(increment: int = 1):
	score += increment
	$UI/MarginContainer/Score.text = str(score)
