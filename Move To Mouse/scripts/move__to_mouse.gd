extends CharacterBody2D

var speed = 400 # move speed
var mousePos = null # null means nothing, so the mousePos is still not defined until the mouse is clicked

func _input(event):
	if event.is_action_pressed("left_click"): # detects if the mouse was left-clicked
		mousePos = get_global_mouse_position() # get the position of the mouse pointer

func _physics_process(delta):
	if mousePos:
		velocity = position.direction_to(mousePos) * speed # move to the mouse pointer
		if position.distance_to(mousePos) < 30: # don't move it the mouse pointer if it was close enough
			velocity = Vector2.ZERO
	move_and_slide()
