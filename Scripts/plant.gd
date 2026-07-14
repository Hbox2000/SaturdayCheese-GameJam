extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var grow_time: Timer = $GrowTimer

@onready var water_drops: Node2D = $WaterDrops
@onready var water_drop_seed: Sprite2D = $WaterDrops/WaterDropSeed
@onready var water_drop_sprout: Sprite2D = $WaterDrops/WaterDropSprout
@onready var water_drop_juv: Sprite2D = $WaterDrops/WaterDropJuv

var _plantTextureId : int = 0
var _plantStage: int = 0
var _plantMaxStage: int = 4
var _plantWatered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = getTexture()
	grow_time.wait_time = randi_range(10, 15)
	grow_time.timeout.connect(grow)
	grow_time.start()

func _process(delta: float) -> void:
	if not _plantWatered:
		water_drops.visible = true
	else:
		water_drops.visible = false
	
	match _plantStage:
		1:
			water_drop_seed.visible = true
			water_drop_sprout.visible = false
			water_drop_juv.visible = false
		2:
			water_drop_seed.visible = false
			water_drop_sprout.visible = true
			water_drop_juv.visible = false
		3:
			water_drop_seed.visible = false
			water_drop_sprout.visible = false
			water_drop_juv.visible = true
		_:
			water_drop_seed.visible = false
			water_drop_sprout.visible = false
			water_drop_juv.visible = false

#Gets the texture from the cropManager using the texture ID and the plant's current stage
func getTexture() -> Resource:
	return cropManager.getTexture(_plantTextureId, _plantStage)
	
#Increases the plantStage by one
func grow() -> void:
	if _plantStage < _plantMaxStage and _plantWatered:
		_plantStage += 1
		sprite_2d.texture = getTexture()
		_plantWatered = false
	
	grow_time.wait_time = randi_range(10, 15)
	grow_time.start()

#Returns the plant's current stage
func getPlantStage() -> int:
	return _plantStage

func waterPlant() -> void:
	_plantWatered = true
