extends Node2D

var plantScene = load("res://Scenes/plant.tscn")

var hasPlant: bool = false
var plantRef: Node2D = null

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
