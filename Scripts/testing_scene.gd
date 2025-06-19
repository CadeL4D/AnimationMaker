extends Control


func _ready() -> void:
	print($Line2D.points)
	print(float(213-120)/float(513-240))
	print(get_global_mouse_position().y)
	print(0.34065934065934*get_global_mouse_position().x)
func _process(delta: float) -> void:
	if get_global_mouse_position().y == 0.34065934065934*get_global_mouse_position().x:
		print("Wtf")
	#if get_global_mouse_position().x > 240 and get_global_mouse_position().x < 513:
		#if get_global_mouse_position().y > 120 and get_global_mouse_position().y < 213:
			#print(get_global_mouse_position())
