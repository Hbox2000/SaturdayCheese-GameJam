extends Node2D

var plantScene = load("res://Scenes/plant.tscn")

var hasPlant: bool = false
var plantRef: Node2D = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		removePlant()

func addPlant(plantId: int, plantStage: int) -> void:
	hasPlant = true
	var plant = plantScene.instantiate()
	plant._plantTextureId = plantId
	plant._plantStage = plantStage
	plant.getTexture()
	plantRef = plant
	
	add_child(plant)

func removePlant() -> void:
	if plantRef != null:
		plantRef.queue_free()
		plantRef = null
		hasPlant = false

func getPlant() -> Node2D:
	return plantRef
