extends AudioStreamPlayer2D

var music_speed := 1.0
var speed_increase := 0.05

@onready var game_timer = $"../Timer"

func _ready() -> void:
	game_timer.reset_all.connect(reset_music_speed)  

func _process(delta: float) -> void:
	# Start speeding up when 15 seconds or less remain
	if game_timer.time <= 15.0 and not game_timer.finished:
		music_speed += speed_increase * delta
		pitch_scale = music_speed

func reset_music_speed() -> void:
	music_speed = 1.0
	pitch_scale = 1.0
