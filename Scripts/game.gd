extends Node2D

@onready var windy_background: AnimatedSprite2D = $WindyBackground
@onready var music: AudioStreamPlayer = $Music

var fullscreened: bool = true
var music_tweens: Dictionary = {}

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
	
	set_layer_volume(1, -80)
	set_layer_volume(2, -80)
	set_layer_volume(3, -80)
	set_layer_volume(4, -80)
	
	if not cropManager.getLivingPlants().is_empty():
		set_layer_volume(1, 0)
	
	for plantId in cropManager.getLivingPlants():
		match plantId:
			1: set_layer_volume(4, 0)
			4:
				set_layer_volume(2, 0)
				set_layer_volume(3, 0)
			5: set_layer_volume(2, 0)
			6: set_layer_volume(2, 0)
			8:
				set_layer_volume(2, 0)
				set_layer_volume(3, 0)
			9:
				set_layer_volume(2, 0)
				set_layer_volume(3, 0)
			10: set_layer_volume(4, 0)
			11: set_layer_volume(2, 0)

func set_layer_volume(layer_index: int, volume_db: float, fade_time: float = 2.0):
	var sync_stream = music.stream as AudioStreamSynchronized
	if not sync_stream:
		return

	if music_tweens.has(layer_index):
		var old_tween = music_tweens[layer_index]
		if old_tween and old_tween.is_valid():
			old_tween.kill()

	var current_volume = sync_stream.get_sync_stream_volume(layer_index)

	var tween = create_tween()
	music_tweens[layer_index] = tween

	tween.tween_method(
		func(v): sync_stream.set_sync_stream_volume(layer_index, v),
		current_volume,
		volume_db,
		fade_time
	).set_trans(Tween.TRANS_LINEAR)
