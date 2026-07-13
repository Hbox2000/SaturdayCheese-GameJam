extends Node2D

var mouse = get_global_mouse_position();
var isOnMouse : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	mouse = get_global_mouse_position()
	if mouse.distance_to(position) < 40 :
		isOnMouse = true
	
	if isOnMouse : 
		global_position = get_global_mouse_position()
func _use() -> void:
	pass

func Use() -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("seed"):
		Use()
