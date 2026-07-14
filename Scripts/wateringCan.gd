extends "res://Scripts/tool.gd"

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click") and is_following():
		var pot := _find_overlapping_pot()
		if pot and pot.hasPlant:
			pot.plantRef.waterPlant()
	
	super._process(delta)

func _ready() -> void:
	super._ready()
	monitoring = true

func _find_overlapping_pot() -> Node2D:
	for area in get_overlapping_areas():
		if area.is_in_group("pot"):
			return area
	return null
