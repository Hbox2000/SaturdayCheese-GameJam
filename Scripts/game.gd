extends Node2D

@onready var windy_background: AnimatedSprite2D = $WindyBackground

var fullscreened: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	windy_background.play()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("fullscreen"):
		match fullscreened:
			true:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				fullscreened = false
		
			false:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				fullscreened = true
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
