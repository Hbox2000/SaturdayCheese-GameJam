extends Area2D
class_name Tool

@export var return_duration: float = 0.3

var _original_position: Vector2

var _is_following: bool = false
var _tween: Tween
var _can_grab : bool = true
var _pick_up_Cooldown_Timer : float = 0.3

var _Grab_Range : float = 50

#var mouse_position : 

func _ready() -> void:
	_original_position = global_position

func _process(_delta: float) -> void:
	if _is_following:
		global_position = get_global_mouse_position()
	
	if _is_following and Input.is_action_just_pressed("right_click"):
		_release()
		get_viewport().set_input_as_handled()
		_can_grab = false
	
	if not _can_grab and _pick_up_Cooldown_Timer >= 0 : 
		_pick_up_Cooldown_Timer = _pick_up_Cooldown_Timer - _delta
		if _pick_up_Cooldown_Timer <= 0 :
			_can_grab = true
			_pick_up_Cooldown_Timer = 0.3
			
	print (get_global_mouse_position().distance_to(position))

func _on_pickup_hitbox_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if not cropManager.holdingTool:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				cropManager.holdingTool = true
				_pick_up()
				_can_grab = false

func is_following() -> bool:
	return _is_following

func _pick_up() -> void:
	_is_following = true
	if _tween:
		_tween.kill()
	_on_picked_up()

func _release() -> void:
	cropManager.holdingTool = false
	_is_following = false
	_on_released()
	_return_to_origin()

func _return_to_origin() -> void:
	_tween = create_tween()
	_tween.tween_property(self, "global_position", _original_position, return_duration)
	_tween.tween_callback(_on_returned)

func _on_picked_up() -> void:
	pass

func _on_released() -> void:
	pass

func _on_returned() -> void:
	pass
