extends Node2D

var frameCount: int = 0
var mainPos: Vector2 = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mainPos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	frameCount = frameCount + 1
	
	position.y = mainPos.y + (100 * sin(frameCount))
