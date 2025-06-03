extends Control

var clicked = false
var event_pos = null
var lineList = []
var newLine = Line2D.new()

func _ready() -> void:
	newLine.default_color = Color("black")
	newLine.antialiased = true
	newLine.begin_cap_mode = 2
	newLine.joint_mode = 2
	newLine.width = 10
	newLine.end_cap_mode = 2
	newLine.round_precision = 10
	self.add_child(newLine)
	
func _input(event: InputEvent) -> void:
	if not Input.is_action_pressed("click"):
		return
	
	event_pos = event.position
	queue_redraw()

func _draw() -> void:
	if(event_pos != null):
		newLine.add_point(event_pos)
