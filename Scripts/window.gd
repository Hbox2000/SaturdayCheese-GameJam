extends Node2D

const seedScene = preload("res://Scenes/seed.tscn")

@onready var window: Area2D = $"."
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
var windowBounds: RectangleShape2D
var numberOfPlants: int
var centerPoint: Vector2

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
	newSeed.seedTextureId = 0
	newSeed.windowBounds = windowBounds
	newSeed.windowCenter = position
	newSeed.position.y = randi_range(collision_shape.position.y - windowBounds.size.y / 2, collision_shape.position.y + windowBounds.size.y / 2)
	newSeed.position.x = collision_shape.position.x - windowBounds.size.x / 2 - 20
	
	add_child(newSeed)
