extends Node2D

const seedScene = preload("res://Scenes/seed.tscn")

@onready var area: Area2D = $Area2D
@onready var collision_shape: CollisionShape2D = $Area2D/CollisionShape2D
var windowBounds: RectangleShape2D
var numberOfPlants: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	windowBounds = collision_shape.shape as RectangleShape2D
	numberOfPlants = cropManager.maxSeedCount() - 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		spawnSeed(0)

func spawnSeed(seedId: int) -> void:
	var newSeed = seedScene.instantiate()
	newSeed._seedTextureId = 0
	newSeed.windowBounds = windowBounds
	newSeed.windowCenter = position
	newSeed.position.y = randi_range(position.y - windowBounds.size.y / 2, position.y + windowBounds.size.y / 2)
	newSeed.position.x = position.x - windowBounds.size.x / 2
	
	add_child(newSeed)
