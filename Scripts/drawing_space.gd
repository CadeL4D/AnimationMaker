extends Control

var newLine = Line2D.new()

func _ready() -> void:
	newLine.default_color = Color( 0.4, 0.5, 1, 1 )

func _draw() -> void:
	newLine.add_point(get_global_mouse_position())
	
func _process(delta: float) -> void:
	queue_redraw()
