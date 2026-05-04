extends Control

@onready var pigs = [$pig1, $pig2, $pig3]

func _ready() -> void:
	assign_roles()

	for pig in pigs:
		pig.setup()


func assign_roles() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	var boar_index = rng.randi_range(0, pigs.size() - 1)

	for i in range(pigs.size()):
		if i == boar_index:
			pigs[i].role = "boar"
		else:
			pigs[i].role = "pig"
