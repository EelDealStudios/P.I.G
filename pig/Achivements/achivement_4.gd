extends Node2D

@onready var sprite = $notfinished4
@onready var label = $"../A4/Label"

func _ready():
	update_achievement()


func update_achievement():
	if Global.achievement_unlocked:
		sprite.texture = preload("res://images/4c1a8c4c74dcf910c0028a54b274f627.jpg")
		label.text = "Achievement unlocked"
	else:
		sprite.texture = preload("res://images/black.png")
		label.text = "Locked"
