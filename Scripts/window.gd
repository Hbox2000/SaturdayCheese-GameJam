extends Node2D

const seedScene = preload("res://Scenes/seed.tscn")

@onready var window: Area2D = $"."
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var seed_timer: Timer = $SeedTimer

var windowBounds: RectangleShape2D
var numberOfPlants: int
var centerPoint: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	windowBounds = collision_shape.shape as RectangleShape2D
	numberOfPlants = cropManager.maxSeedCount() - 1
	seed_timer.wait_time = randf_range(0.5, 1)
	seed_timer.timeout.connect(spawnSeed.bind(randi_range(0, cropManager.maxSeedCount() - 1)))
	seed_timer.start()

func spawnSeed(seedId: int) -> void:
	var newSeed = seedScene.instantiate()
	newSeed.seedTextureId = seedId
	newSeed.windowBounds = windowBounds
	newSeed.windowCenter = position
	newSeed.position.y = randf_range(collision_shape.position.y - windowBounds.size.y / 2, collision_shape.position.y + windowBounds.size.y / 2)
	newSeed.position.x = collision_shape.position.x - windowBounds.size.x / 2 - 20
	
	add_child(newSeed)
	
	seed_timer.wait_time = randf_range(0.5, 1)
	seed_timer.start()
