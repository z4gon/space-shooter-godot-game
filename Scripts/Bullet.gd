extends RigidBody2D

onready var shoot_sound = $ShootSound

func _ready():
	shoot_sound.play()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
