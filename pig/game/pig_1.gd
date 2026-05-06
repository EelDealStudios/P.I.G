extends Node2D

var role = "pig"
var rng = RandomNumberGenerator.new()

@onready var pig_sprite = $PigSprite1
@onready var boar_sprite = $BoarSprite1

func _ready():
	rng.randomize()


func setup():
	print(name + " is " + role)

	# always reset boar visibility at start of round
	boar_sprite.visible = false


func show_boar():
	boar_sprite.visible = true


func hide_boar():
	boar_sprite.visible = false


func answer(boar_name: String):
	var responses = []

	if role == "boar":
		responses = get_boar_responses(boar_name)
	else:
		responses = get_pig_responses(boar_name)

	if responses.is_empty():
		print(name + " has no responses")
		return

	var choice = responses[rng.randi_range(0, responses.size() - 1)]
	print(name + " says: " + choice)


func get_boar_responses(boar_name: String) -> Array:
	match boar_name:
		"pig1":
			return ["it's pig2", "it's pig3", "it's not pig1", "it's either pig2 or pig3"]
		"pig2":
			return ["it's pig1", "it's pig3", "it's not pig2", "it's either pig1 or pig3"]
		"pig3":
			return ["it's pig1", "it's pig2", "it's not pig3", "it's either pig1 or pig2"]

	return []


func get_pig_responses(boar_name: String) -> Array:
	match boar_name:
		"pig1":
			return ["it's pig1", "it's not pig2", "it's not pig3", "it's either pig1 or pig2", "it's either pig1 or pig3"]
		"pig2":
			return ["it's pig2", "it's not pig1", "it's not pig3", "it's either pig1 or pig2", "it's either pig2 or pig3"]
		"pig3":
			return ["it's pig3", "it's not pig1", "it's not pig2", "it's either pig1 or pig3", "it's either pig2 or pig3"]

	return []
