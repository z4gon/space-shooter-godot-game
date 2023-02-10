# Space Shooter Game
Godot 3.5.x

A basic game made in Godot, following the course: https://heartbeast-gamedev-school.teachable.com/p/1-bit-godot-course

## Screenshots

![Picture](./docs/screencapture.jpg)

## Project Setup

- Set Window Height/Width, Test Height/Width and Stretch Mode to 2D.
- Turn on Smart Snapping to 16px and show the Grid.

## Nodes Used

- Node
  - Node2D
    - Area2D
    - Sprite
    - ColliderPolygon2D
    - RigidBody2D
    - VisibilityNotifier2D

## Scenes

- World
- Ship
- Enemy

## Shoot Bullets: Instancing

- Get a reference to a `Scene`

```py
var Bullet : Resource = preload("res://Scenes/Bullet.tscn")
```

- Instantiate the resource.
- Add it to the root node of the scene.
- Set its position.
  
```py
# FIXME: This is not ideal, an object pool should be used instead.
func shoot():
	var bullet = Bullet.instance()				# instantiate the scene
	var root_node = get_tree().current_scene 	# get the root node of the main scene
	root_node.add_child(bullet)					# add to the root node
	bullet.global_position = global_position	# position in the same place as the ship
	bullet.global_position.x += 10
```

## Collisions

### Layers

- Name the Physics 2D layers.
- Set `Ship` to be in the Ship `Layer`
- Set `Bullet` to be in the Bullets `Layer`
- Set `Enemy` to be in the Enemies `Layer`

### Masks

- `Mask` the collisions of the `Ship` to only interact with `Enemies`
- `Mask` the collisions of the `Enemies` to only interact with `Bullets`
  
### Signals

- Use signal `area_entered` to detect collision between the Ship and Enemies.

```py
# on collision with bullets
func _on_Enemy_body_entered(bullet_node: Node):
	bullet_node.queue_free()
	
	currentHP -= 1
	if currentHP == 0:
		queue_free()
```

- Use signal `body_entered` to detect collisison between Enemies and Bullets.

```py
# on collision with enemies
func _on_Ship_area_entered(enemy_area: Area2D):
	enemy_area.queue_free()
	queue_free()
```

## Visibility Notifiers

- Add `VisibiliyNotifier2D` nodes to the Enemies and Bullets.
- Connect the signal `screen_exited` to a function that executes `queue_free()`

```py
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
```

## Enemy Spawner: Instancing

### Spawn Points

- Export an `Array` of `NodePath` to have references to different spawn points as needed.
- Then use a custom function to load these nodes to be able to access their position.

```py
const Utils = preload("res://Scripts/Utils.gd")

export(Array, NodePath) var spawn_points_node_paths = [] 
onready var spawn_points: Array = Utils.load_nodes(self, spawn_points_node_paths)
```

```py
static func load_nodes(context: Node, node_paths: Array) -> Array:
	var nodes = []
	for node_path in node_paths:
		var node = context.get_node(node_path)
		if node != null:
			nodes.append(node)
	return nodes
```

### Randomizer

- Use a pseudo random number generator to pick a random spawn point.
- Return the position to use when positioning the newly spawned enemy.

```py
const Enemy : Resource = preload("res://Scenes/Enemy.tscn")

var rng = RandomNumberGenerator.new()
```

```py
func get_spawn_position() -> Vector2:
	var idx = rng.randi_range(0, spawn_points.size() - 1)
	var point = spawn_points[idx]
	return 	point.global_position
```

### Spawn the Enemy

```py
func spawn_enemy():
	var enemy = Enemy.instance()						# instantiate the scene
	var root_node = get_tree().current_scene 			# get the root node of the main scene
	root_node.add_child(enemy)						# add to the root node
	enemy.global_position = get_spawn_position()		# position in a random spawn point
```