extends Panel

signal reset_all   

var time: float = 31.0
var seconds: int = 31
var finished := false
var paused := false

func _ready() -> void:
	$"../HBoxContainer/itispig1".pressed.connect(reset_timer)
	$"../HBoxContainer/itispig2".pressed.connect(reset_timer)
	$"../HBoxContainer/itispig3".pressed.connect(reset_timer)

func _process(delta: float) -> void:
	if finished or paused:
		return
	
	time = max(time - delta, 0)
	seconds = int(time)
	$Seconds.text = "%02d" % seconds
	
	if time == 0 and not finished:
		finished = true
		$"../fart".play()
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://GameOver/GameOver.tscn")

func reset_timer() -> void:
	# Reset timer
	time = 31.0
	seconds = 31
	
	reset_all.emit()

	# Pause countdown for 3 seconds
	if not paused:
		paused = true
		await get_tree().create_timer(3.0).timeout
		paused = false
