extends Node2D

const windSpeed : float = 2
var numFrames : int = 0
var mainPos : Vector2 = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = randi_range(40, get_window().size.y - 40)
	position.x = -200
	mainPos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	numFrames = numFrames + 1
	
	position.y = mainPos.y + (20 * sin(numFrames * 0.05))
	position.x = position.x + windSpeed
