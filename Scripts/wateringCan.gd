extends "res://Scripts/tool.gd"
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var useTimer: Timer = $Timer
@onready var water_pour: AudioStreamPlayer = $WaterPour

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and is_following():
		var pot := _find_overlapping_pot()
		if pot and pot.hasPlant:
			pot.plantRef.waterPlant()
			useTimer.wait_time = 1
			useTimer.start()
			anim.play("Use")
			water_pour.play()
			
	if useTimer.is_stopped():
		anim.play("Idle")
		
	super._process(delta)

func _ready() -> void:
	super._ready()
	monitoring = true
	
	
func _find_overlapping_pot() -> Node2D:
	for area in get_overlapping_areas():
		if area.is_in_group("pot"):
			return area
	return null

func _on_picked_up() -> void:
	z_index = 5

func _on_returned() -> void:
	z_index = 3
