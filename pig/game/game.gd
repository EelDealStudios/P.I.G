extends Control

@onready var pigs = [$pig1, $pig2, $pig3]
@onready var round_label = $Panel2/RI

var current_boar = null
var round_active = true

var current_round := 1
var max_rounds := 6

# NEW: score tracking
var correct_guesses := 0
var wrong_guesses := 0


func _ready() -> void:
	start_round()


func start_round():
	# If all rounds are finished, decide ending
	if current_round > max_rounds:
		finish_game()
		return

	# UPDATE LABEL
	round_label.text = "Round " + str(current_round)

	print("ROUND ", current_round)

	assign_roles()

	for pig in pigs:
		pig.setup()

	# find and store the boar
	current_boar = null
	for pig in pigs:
		if pig.role == "boar":
			current_boar = pig
			break

	round_active = true


func finish_game():
	print("Game finished!")

	print("Correct: ", correct_guesses)
	print("Wrong: ", wrong_guesses)

	# GOOD ENDING
	if correct_guesses >= 4:
		get_tree().change_scene_to_file("res://Endings/GoodEnding.tscn")

	# NEUTRAL ENDING
	elif correct_guesses == 3 and wrong_guesses == 3:
		get_tree().change_scene_to_file("res://Endings/Ending.tscn")

	# BAD ENDING
	elif wrong_guesses >= 4:
		get_tree().change_scene_to_file("res://Endings/BadEnding.tscn")


func end_round_and_continue():
	round_active = false

	await get_tree().create_timer(2.0).timeout

	current_round += 1
	start_round()


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
		correct_guesses += 1
		pig.show_boar()
	else:
		print("WRONG!")
		wrong_guesses += 1

	# delay before next round
	await get_tree().create_timer(1.0).timeout

	# remove boar appearance
	for p in pigs:
		p.hide_boar()

	end_round_and_continue()


func _on_itispig_1_pressed() -> void:
	guess_pig($pig1)


func _on_itispig_2_pressed() -> void:
	guess_pig($pig2)


func _on_itispig_3_pressed() -> void:
	guess_pig($pig3)
