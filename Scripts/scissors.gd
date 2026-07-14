extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click") :
		var pot := _find_overlapping_pot()
		if pot != null :
			animated_sprite_2d.play()
			pot.removePlant()

func _find_overlapping_pot() -> Node2D:
	for area in get_overlapping_areas():
		if area.is_in_group("pot"):
			return area
	return null
