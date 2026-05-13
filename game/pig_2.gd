extends Node2D

var role = "pig"
var rng = RandomNumberGenerator.new()

@onready var pig_sprite = $PigSprite2
@onready var boar_sprite = $BoarSprite2
@onready var pa1 = $"../HBoxContainer2/pa2l/MarginContainer/pa2"

func _ready():
	rng.randomize()


func setup():
	# debug only (console)
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
		pa1.text = name + " has no responses"
		return

	var choice = responses[rng.randi_range(0, responses.size() - 1)]
	pa1.text = choice


func get_boar_responses(boar_name: String) -> Array:
	match boar_name:
		"pig1":
			return ["it's Suspect B", "it's Suspect C", "it's not Suspect A", "it's either Suspect B or Suspect C"]
		"pig2":
			return ["it's Suspect A", "it's Suspect C", "it's not Suspect B", "it's either Suspect A or Suspect C"]
		"pig3":
			return ["it's Suspect A", "it's Suspect B", "it's not Suspect C", "it's either Suspect A or Suspect B"]

	return []


func get_pig_responses(boar_name: String) -> Array:
	match boar_name:
		"pig1":
			return ["it's Suspect A", "it's not Suspect B", "it's not Suspect C", "it's either Suspect A or Suspect B", "it's either Suspect A or Suspect C"]
		"pig2":
			return ["it's Suspect B", "it's not Suspect A", "it's not Suspect C", "it's either Suspect A or Suspect B", "it's either Suspect B or Suspect C"]
		"pig3":
			return ["it's Suspect C", "it's not Suspect A", "it's not Suspect B", "it's either Suspect A or Suspect C", "it's either Suspect B or Suspect C"]

	return []
