extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var grow_time: Timer = $GrowTimer
@onready var want_water_anim: AnimatedSprite2D = $WantWaterAnim

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
	want_water_anim.play()

# Basically tick
func _process(_delta: float) -> void:
	if not _plantWatered:
		want_water_anim.visible = true
	
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
	want_water_anim.visible = false
