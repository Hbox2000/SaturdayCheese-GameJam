extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
const windSpeed : float = 2
var numFrames : int = 0
var mainPos : Vector2 = position
var windowBounds: RectangleShape2D
var windowCenter: Vector2

var _seedTextureId : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mainPos = position
	sprite_2d.scale = sprite_2d.scale / 6
	_seedTextureId = randi_range(0, cropManager.maxSeedCount() - 1)
	sprite_2d.texture = getTexture() # this will error until the seed manager is implemented

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	numFrames = numFrames + 1
	
	position.y = mainPos.y + (20 * sin(numFrames * 0.05))
	position.x = position.x + windSpeed
	
	if position.x > windowCenter.x + windowBounds.size.x / 2 + 20:
		queue_free()

func getTexture() -> Resource:
	return cropManager.getTexture(_seedTextureId, 0)
