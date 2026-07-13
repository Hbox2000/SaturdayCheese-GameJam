extends Sprite2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var skib := load("res://Assets/Plants/0_DebugPlant/2_DebugPlant.png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		texture = cropManager.getTexture(0, 1)
