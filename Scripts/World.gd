extends Node

onready var score_label: Label = $ScoreLabel

var score = 0 setget set_score

func _on_Enemy_killed_by_player():
	self.score += 10

func set_score(value):
	score = value
	score_label.text = "Score = %s" % score
