extends Area2D

export(int) var SPEED = 100

var Bullet : Resource = preload("res://Scenes/Bullet.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_movement(delta)
	process_shooting()

func process_movement(delta):
	var speed = SPEED * delta
	
	if Input.is_action_pressed("ui_up"):
		move(0, -speed)
	if Input.is_action_pressed("ui_down"):
		move(0, speed)

func move(dx: float, dy: float):
	position.x += dx
	position.y += dy

func process_shooting():
	if Input.is_action_just_pressed("ui_accept"):
		shoot()

# FIXME: This is not ideal, an object pool should be used instead.
func shoot():
	var bullet = Bullet.instance()				# instantiate the scene
	var root_node = get_tree().current_scene 		# get the root node of the main scene
	root_node.add_child(bullet)					# add to the root node
	bullet.global_position = global_position		# position in the same place as the ship
	bullet.global_position.x += 10

# on collision with enemies
func _on_Ship_area_entered(enemy_area: Area2D):
	enemy_area.queue_free()
	queue_free()
