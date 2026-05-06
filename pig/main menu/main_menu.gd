extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Achivements/Achivements.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_button_pressed() -> void:
	$AudioStreamPlayer2D2.play()
	
func _on_buttonagain_pressed() -> void:
	pass
