extends Control


func _on_draw_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/drawing_space.tscn")
