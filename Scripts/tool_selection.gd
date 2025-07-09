extends Control

signal pressedButton

func _on_pressed(extra_arg_0: String) -> void:
	pressedButton.emit(extra_arg_0)
