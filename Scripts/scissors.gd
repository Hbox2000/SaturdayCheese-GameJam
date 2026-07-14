extends "res://Scripts/tool.gd"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var seed_destroyed: AudioStreamPlayer = $SeedDestroyed
@onready var scissors: AudioStreamPlayer = $Scissors

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	monitoring = true
	animated_sprite_2d.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_following():
		if Input.is_action_just_pressed("left_click") :
			var pot := _find_overlapping_pot()
			if pot != null and pot.hasPlant:
				pot.removePlant()
				seed_destroyed.play()
			animated_sprite_2d.play("cut")
			scissors.play()
	
	super._process(delta)

func _find_overlapping_pot() -> Node2D:
	for area in get_overlapping_areas():
		if area.is_in_group("pot"):
			return area
	return null

func _on_picked_up() -> void:
	animated_sprite_2d.rotation = 0
	z_index = 5
	animated_sprite_2d.play("open")

func _on_released() -> void:
	animated_sprite_2d.rotate(deg_to_rad(180))
	z_index = 3
	animated_sprite_2d.play("default")
