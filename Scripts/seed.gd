extends Node2D
@onready var sprite_2d: Sprite2D = $Wind/Sprite2D

var _seedTextureId : int = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	sprite_2d.scale = sprite_2d.scale / 6
	_seedTextureId = randi_range(0, cropManager.maxSeedCount())
	sprite_2d.texture = getTexture() # this will error until the seed manager is implemented


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TODO : add movement stuff here
	pass

func getTexture() -> Resource:
	return cropManager.getTexture(_seedTextureId, 0)
