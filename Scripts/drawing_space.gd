extends Control

var clicked = false
var event_pos = null
var lineList = {}
var UUID = 0
var newLine = Line2D.new()
var line

func _ready() -> void:
	addingNewLine()
	
func _process(delta: float) -> void:
	if Input.is_action_just_released("click"):
		#lineList[UUID].append(lineList[lineList.keys()[-1]][0].get_points())
		print(lineList)
		addingNewLine(1)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("undo"):
		undo()
	if not Input.is_action_pressed("click"):
		return
	event_pos = event.position
	queue_redraw()

func _draw() -> void:
	if(event_pos != null) and Input.is_action_pressed("click"):
		lineList[UUID][0].add_point(event_pos)

		
func addingNewLine(flip = 0):
		UUID += flip
		lineList[UUID] = [Line2D.new()]
		lineList[UUID][0].default_color = Color("black")
		lineList[UUID][0].antialiased = true
		lineList[UUID][0].begin_cap_mode = 2
		lineList[UUID][0].joint_mode = 2
		lineList[UUID][0].width = 10
		lineList[UUID][0].end_cap_mode = 2
		lineList[UUID][0].round_precision = 10
		self.add_child(lineList[UUID][0])
		
func undo():
	lineList[lineList.keys()[-2]][0].clear_points()
	lineList.erase(lineList.keys()[-2])

	

	
