extends "res://Scripts/tool.gd"

@onready var seed_placement: Node2D = $SeedPlacement

@onready var succesful_catch: AudioStreamPlayer = $SuccesfulCatch
@onready var seed_planted: AudioStreamPlayer = $SeedPlanted

var overlappedSeed: Node2D = null
var capturedSeed: Node2D = null

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("left_click"):
		if overlappedSeed and not capturedSeed and is_following():
			capturedSeed = overlappedSeed
			overlappedSeed = null
			_capture_seed.call_deferred(capturedSeed)
			return
		
		if capturedSeed:
			var pot := _find_overlapping_pot()
			if pot:
				if not pot.hasPlant:
					pot.addPlant(capturedSeed.seedTextureId, 1)
					capturedSeed.queue_free()
					capturedSeed = null
					seed_planted.play()
			else:
				capturedSeed.queue_free()
				capturedSeed = null
	
	super._process(delta)

func _ready() -> void:
	super._ready()
	monitoring = true
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if is_following() and area.is_in_group("seed"):
		overlappedSeed = area

func _on_area_exited(area: Area2D) -> void:
	if overlappedSeed == area:
		overlappedSeed = null

func _capture_seed(capturedSeed: Area2D) -> void:
	var old_parent := capturedSeed.get_parent()
	if old_parent:
		old_parent.remove_child(capturedSeed)
	add_child(capturedSeed)
	capturedSeed.position = seed_placement.position
	capturedSeed.windActive = false
	succesful_catch.play()

func _find_overlapping_pot() -> Node2D:
	for area in get_overlapping_areas():
		if area.is_in_group("pot"):
			return area
	return null

func _on_picked_up() -> void:
	z_index = 5

func _on_returned() -> void:
	if capturedSeed:
		capturedSeed.queue_free()
		capturedSeed = null
	z_index = 3
