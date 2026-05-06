extends Control

@onready var pigs = [$pig1, $pig2, $pig3]

var current_boar = null
var round_active = true


func _ready() -> void:
	start_round()


func start_round():
	assign_roles()

	for pig in pigs:
		pig.setup()

# find and store the boar
	for pig in pigs:
		if pig.role == "boar":
			current_boar = pig
			break

	round_active = true


func assign_roles() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var boar_index = rng.randi_range(0, pigs.size() - 1)

	for i in range(pigs.size()):
		pigs[i].role = "boar" if i == boar_index else "pig"


func _on_question_pressed() -> void:
	var boar = current_boar

	for pig in pigs:
		pig.answer(boar.name)


func guess_pig(pig):
	if not round_active:
		return

	print("IT'S THIS PIG!")

	round_active = false

	if pig == current_boar:
		print("CORRECT!")
		pig.show_boar()
	else:
		print("wrong")

	await get_tree().create_timer(3.0).timeout

	# remove boar appearance
	for p in pigs:
		p.hide_boar()

	start_round()

func _on_itispig_1_pressed() -> void:
	guess_pig($pig1)
	
func _on_itispig_2_pressed() -> void:
	guess_pig($pig2)

func _on_itispig_3_pressed() -> void:
	guess_pig($pig3)
