extends Area2D

const Utils = preload("res://Scripts/Utils.gd")
var ExplosionVFX : Resource = preload("res://Scenes/ExplosionVFX.tscn")

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
func _on_Enemy_body_entered(bullet_node: Node):
	bullet_node.queue_free()
	
	currentHP -= 1
	if currentHP == 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _exit_tree():
	Utils.instantiate(self, ExplosionVFX, global_position)
