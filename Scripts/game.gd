extends Node2D

@onready var windy_background: AnimatedSprite2D = $WindyBackground
@onready var music: AudioStreamPlayer = $Music

var fullscreened: bool = true

var musicLayer1Plants: Array[int] = [5, 6]
var musicLayer2Plants: Array[int] = [1]

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
	
	if Input.is_action_just_pressed("ui_left"):
		music.play()
	
	set_layer_volume(1, -80)
	set_layer_volume(2, -80)
	set_layer_volume(3, -80)
	
	if not cropManager.getLivingPlants().is_empty():
		set_layer_volume(1, 0)
	
	for plantId in cropManager.getLivingPlants():
		if plantId == 5 or plantId == 6:
			set_layer_volume(2, 0)
		
		if plantId == 1:
			set_layer_volume(3, 0)

func set_layer_volume(layer_index: int, volume_db: float):
	var sync_stream = music.stream as AudioStreamSynchronized
	if sync_stream:
		sync_stream.set_sync_stream_volume(layer_index, volume_db)
