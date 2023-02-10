extends Area2D

export(int) var SPEED = 100
export(int) var HP = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_movement(delta)

func process_movement(delta):
	var speed = SPEED * delta
	move(-speed, 0)

func move(dx: float, dy: float):
	position.x += dx
	position.y += dy
