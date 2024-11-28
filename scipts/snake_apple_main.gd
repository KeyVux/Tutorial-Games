extends Node
@export var snake_scene: PackedScene
# Game variables
var score: int = 0
var gameStarted: bool = false

# Grid variables
var cells: int = 20
var cellSize: int = 50

# Food variables
var foodPos: Vector2
var regenFood: bool = true

# Snake variables
var oldData: Array = []
var snakeData: Array = []
var snake: Array = []

# Movement variables
var startPos: Vector2 = Vector2(9, 9)
var up: Vector2 = Vector2(0, -1)
var down: Vector2 = Vector2(0, 1)
var left: Vector2 = Vector2(-1, 0)
var right: Vector2 = Vector2(1, 0)
var moveDirection: Vector2 = Vector2.ZERO
var canMove: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	newGame()
	move_food()

func newGame():
	get_tree().paused = false
	get_tree().call_group("segments", "queue_free")
	$GameOverMenu.hide()
	score = 0
	$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
	moveDirection = up
	canMove = true
	generateSnake()

func generateSnake():
	oldData.clear()
	snakeData.clear()
	snake.clear()
	for i in range(3):
		addSegment(startPos + Vector2(0, i))

func addSegment(pos):
	snakeData.append(pos)
	var snakeSegment = snake_scene.instantiate()
	snakeSegment.position = (pos * cellSize) + Vector2(0, cellSize)
	add_child(snakeSegment)
	snake.append(snakeSegment)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	moveSnake()
	
func moveSnake():
	
	if not canMove:
		return

	# Update movement from key presses
	if Input.is_action_just_pressed("move_down") and moveDirection != up:
		moveDirection = down
		canMove = false

	if Input.is_action_just_pressed("move_up") and moveDirection != down:
		moveDirection = up
		canMove = false

	if Input.is_action_just_pressed("move_left") and moveDirection != right:
		moveDirection = left
		canMove = false

	if Input.is_action_just_pressed("move_right") and moveDirection != left:
		moveDirection = right
		canMove = false
		
	if not gameStarted:
		startGame()

func startGame():
	gameStarted = true
	$MoveTimer.start()


func _on_move_timer_timeout() -> void:
	canMove = true
	# Use the snake's previous position to move the segments
	oldData = [] + snakeData
	snakeData[0] += moveDirection

	for i in range(len(snakeData)):
		# Move all the segments along by one
		if i > 0:
			snakeData[i] = oldData[i - 1]
		snake[i].position = (snakeData[i] * cellSize) + Vector2(0, cellSize)
		
	checkOutOfBounds()
	checkSelfEaten()
	checkFoodEaten()
	
func checkOutOfBounds():
	if snakeData[0].x < 0 or snakeData[0].x > cells - 1 or snakeData[0].y < 0 or snakeData[0].y > cells - 1:
		end_game()

func checkSelfEaten():
	for i in range(1, len(snakeData)):
		if snakeData[0] == snakeData[i]:
			end_game()

func move_food():
	while regenFood:
		regenFood = false
		foodPos = Vector2(randi_range(0, cells - 1), randi_range(0, cells - 1))
		for i in snakeData:
			if foodPos == i:
				regenFood = true
	$Food.position = (foodPos * cellSize) + Vector2(0, cellSize)
	regenFood = true

func checkFoodEaten():
	# If snake eats the food, add a segment and move the food
	if snakeData[0] == foodPos:
		score += 1
		$HUD.get_node("ScoreLabel").text = "SCORE: " + str(score)
		addSegment(oldData[-1])
		move_food()  # Move food to a new position after eating

func end_game():
	$GameOverMenu.show()
	gameStarted = false
	$MoveTimer.stop()
	get_tree().paused = true


func _on_game_over_menu_restart() -> void:
	newGame()
