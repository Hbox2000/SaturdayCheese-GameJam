extends Node2D

@onready var windy_background: AnimatedSprite2D = $WindyBackground

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	windy_background.play()
