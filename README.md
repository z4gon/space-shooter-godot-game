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

## Scenes

- World
- Ship
- Enemy

## Instancing

- Get a reference to a `Scene`

```py
var Bullet : Resource = preload("res://Scenes/Bullet.tscn")
```

- Instantiate the resource.
- Add it to the root node of the scene.
- Set its position.
  
> NOTE: This is not ideal, an object pool should be used instead.

```py
func shoot():
	var bullet = Bullet.instance()				# instantiate the scene
	var rootNode = get_tree().current_scene 	# get the root node of the main scene
	rootNode.add_child(bullet)					# add to the root node
	bullet.global_position = global_position	# position in the same place as the ship
	bullet.global_position.x += 10
```