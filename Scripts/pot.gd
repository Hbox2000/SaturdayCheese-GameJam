extends Node2D

var plantScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	plantScene = load("res://Scenes/plant.tscn")
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		addPlant(0, 0)

func addPlant(plantId: int, plantStage: int):
	var newPlant = plantScene.instantiate()
	newPlant._plantTextureId = plantId
	newPlant._plantStage = plantStage
	
	
	newPlant.position = position + Vector2(-8, -74)
	get_tree().current_scene.add_child(newPlant)
