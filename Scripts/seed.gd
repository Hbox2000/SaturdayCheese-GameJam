extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
var windSpeed : float
var numFrames : int = 2
var mainPos : Vector2 = position
var windowBounds: RectangleShape2D
var windowCenter: Vector2
var windActive: bool = true

var seedTextureId : int;

func _ready() -> void:
	mainPos = position
	sprite_2d.scale = sprite_2d.scale / 6
	seedTextureId = randi_range(0, cropManager.maxSeedCount() - 1)
	sprite_2d.texture = getTexture()
	windSpeed = randf_range(0.2, 1)

func _process(_delta: float) -> void:
	numFrames = numFrames + 1
	
	if windActive:
		position.y = mainPos.y + (20 * sin(numFrames * 0.01))
		position.x = position.x + windSpeed
		if position.x > windowCenter.x + windowBounds.size.x / 2 + 20:
			queue_free()

func getTexture() -> Resource:
	return cropManager.getTexture(seedTextureId, 0)
