extends Control

var clicked = false
var event_pos = null
var lineList = {}
var UUID = 0
var newLine = Line2D.new()
var line

func _ready() -> void:
	lineList[UUID] = [Line2D.new()]
	lineList[UUID][0].default_color = Color("black")
	lineList[UUID][0].antialiased = true
	lineList[UUID][0].begin_cap_mode = 2
	lineList[UUID][0].joint_mode = 2
	lineList[UUID][0].width = 10
	lineList[UUID][0].end_cap_mode = 2
	lineList[UUID][0].round_precision = 10
	self.add_child(lineList[UUID][0])
	
	#newLine.default_color = Color("black")
	#newLine.antialiased = true
	#newLine.begin_cap_mode = 2
	#newLine.joint_mode = 2
	#newLine.width = 10
	#newLine.end_cap_mode = 2
	#newLine.round_precision = 10
	#self.add_child(newLine)
	#line = newLine
	
func _process(delta: float) -> void:
	if Input.is_action_just_released("click"):
		addingNewLine()


func _input(event: InputEvent) -> void:
	if not Input.is_action_pressed("click"):
		return
	
	event_pos = event.position
	queue_redraw()

func _draw() -> void:
	if(event_pos != null) and Input.is_action_pressed("click"):
		print(lineList[UUID])
		lineList[UUID][0].add_point(event_pos)
		#print(line)
		#line.add_point(event_pos)
		
func addingNewLine():
		UUID += 1
		lineList[UUID] = [Line2D.new()]
		lineList[UUID][0].default_color = Color("black")
		lineList[UUID][0].antialiased = true
		lineList[UUID][0].begin_cap_mode = 2
		lineList[UUID][0].joint_mode = 2
		lineList[UUID][0].width = 10
		lineList[UUID][0].end_cap_mode = 2
		lineList[UUID][0].round_precision = 10
		self.add_child(lineList[UUID][0])
	
