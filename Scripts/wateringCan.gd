extends "res://Scripts/tool.gd"

@onready var seed_placement: Node2D = $SeedPlacement

var captured_seed: Node2D = null

func _process(delta: float) -> void:
	if captured_seed and Input.is_action_just_pressed("left_click"):
		var pot := _find_overlapping_pot()
		if pot and not pot.hasPlant:
			pot.addPlant(captured_seed.seedTextureId, 0)
			captured_seed.queue_free()
			captured_seed = null
	
	super._process(delta)

func _ready() -> void:
	super._ready()
	monitoring = true
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if is_following() and captured_seed == null and area.is_in_group("seed"):
		captured_seed = area
		_capture_seed.call_deferred(area)

func _capture_seed(capturedSeed: Area2D) -> void:
	var old_parent := capturedSeed.get_parent()
	if old_parent:
		old_parent.remove_child(capturedSeed)
	add_child(capturedSeed)
	capturedSeed.position = seed_placement.position
	capturedSeed.windActive = false

func _find_overlapping_pot() -> Node2D:
	for area in get_overlapping_areas():
		if area.is_in_group("pot"):
			return area
	return null

func _on_returned() -> void:
	if captured_seed:
		captured_seed.queue_free()
		captured_seed = null
