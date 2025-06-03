extends Control

signal pressedButton


func _process(delta: float) -> void:
	$ColorRect.position = get_global_mouse_position()
	
