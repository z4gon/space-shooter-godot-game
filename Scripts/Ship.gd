extends Area2D

export(int) var SPEED = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_movement(delta)

func process_movement(delta):
	var speed = SPEED * delta
	
	if Input.is_action_pressed("ui_up"):
		move(0, -speed)
	if Input.is_action_pressed("ui_down"):
		move(0, speed)

func move(dx: float, dy: float):
	position.x += dx
	position.y += dy
