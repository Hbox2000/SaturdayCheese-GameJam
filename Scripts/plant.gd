extends Node2D

var _plantTextureId : int = 0
var _plantStage: int = 0
var _plantMaxStage: int = 4;

#Getting reference to sprite
@onready var sprite_2d: Sprite2D = $Wind/Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = getTexture()
	

# Basically tick
func _process(delta: float) -> void:
	pass
	print("hi")
	
#Gets the texture from the cropManager using the texture ID and the plant's current stage
func getTexture() -> Resource:
	return cropManager.getTexture(_plantTextureId, _plantStage)
	
#Increases the plantStage by one
func grow() -> void:
	if (_plantStage < _plantMaxStage):
		_plantStage += 1
		
	else:
		push_error("Plant stage was somehow over the limit when calling grow()")
	
	
#Returns the plant's current stage
func getPlantStage() -> int:
	return _plantStage
