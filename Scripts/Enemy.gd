extends Area2D

const Utils = preload("res://Scripts/Utils.gd")
var ExplosionVFX : Resource = preload("res://Scenes/ExplosionVFX.tscn")

export(int) var SPEED = 100
export(int) var HP = 3

var currentHP = 0

signal killed_by_player

func _ready():
	currentHP = HP
	connect_signals()

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
		emit_signal("killed_by_player")
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _exit_tree():
	Utils.instantiate(self, ExplosionVFX, global_position)
	
func connect_signals():
	var root_node = get_tree().current_scene
	if root_node.is_in_group("World"):
		connect("killed_by_player", root_node, "_on_Enemy_killed_by_player")
