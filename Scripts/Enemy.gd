extends Area2D

export(int) var SPEED = 100
export(int) var HP = 3

var currentHP = 0

func _ready():
	currentHP = HP

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_movement(delta)

func process_movement(delta):
	var speed = SPEED * delta
	move(-speed, 0)

func move(dx: float, dy: float):
	position.x += dx
	position.y += dy

# on collision with bullets
func _on_Enemy_body_entered(bulletNode: Node):
	bulletNode.queue_free()
	
	currentHP -= 1
	if currentHP == 0:
		queue_free()
