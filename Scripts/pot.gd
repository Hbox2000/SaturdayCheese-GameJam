extends Node2D

var plantScene = load("res://Scenes/plant.tscn")

var hasPlant: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		addPlant(1, 0)

func addPlant(plantId: int, plantStage: int):
	hasPlant = true
	var plant = plantScene.instantiate()
	plant._plantTextureId = plantId
	plant._plantStage = plantStage
	plant.getTexture()
	
	add_child(plant)
