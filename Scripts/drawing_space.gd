extends Control

var clicked = false
var event_pos = null
var lineList = {}
var redoList = []
var UUID = 0
var newLine = Line2D.new()
var line
var selected_tool = "paint"
var tool_radius = 100
var background_color = Color.WHITE

func _ready() -> void:
	$Control.size.x = get_viewport().size.x
	$Control.size.y = get_viewport().size.y-80
	addingNewLine()
	
func _process(delta: float) -> void:
	if Input.is_action_just_released("click"):
		addingNewLine(1)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("undo"):
		undo()
	if Input.is_action_just_pressed("redo"):
		redo()
	if event is InputEventMouseMotion and selected_tool == "eraser":
		event_pos = event.position
		queue_redraw()
	if not Input.is_action_pressed("click"):
		return
	event_pos = event.position
	queue_redraw()

func _draw() -> void:
	#draw circle for eraser indicator
	if(selected_tool == "eraser"):
		draw_circle(event_pos,tool_radius,Color.BLACK,false,tool_radius/5)
	if(event_pos != null) and Input.is_action_pressed("click") and selected_tool == "paint":
		lineList[UUID][0].width = tool_radius
		lineList[UUID][0].add_point(event_pos)
		lineList[UUID][1].append(event_pos)
	elif(event_pos != null) and Input.is_action_pressed("click") and selected_tool == "eraser":
		lineList[UUID][0].width = tool_radius
		lineList[UUID][0].add_point(event_pos)
		lineList[UUID][1].append(event_pos)

func addingNewLine(flip = 0):
	#test if tool is paint before adding new Line2D otherwise it creates one with other tools
	UUID += flip
	lineList[UUID] = [Line2D.new(),[]]
	if selected_tool == "eraser":
		lineList[UUID][0].default_color = background_color
	else:
		lineList[UUID][0].default_color = $tool_selection/HBoxContainer/ColorPickerButton.color
	lineList[UUID][0].antialiased = true
	lineList[UUID][0].begin_cap_mode = 2
	lineList[UUID][0].joint_mode = 2
	lineList[UUID][0].width = 10
	lineList[UUID][0].end_cap_mode = 2
	lineList[UUID][0].round_precision = 10
	$Control/ColorRect.add_child(lineList[UUID][0])
	print(UUID)
		
func undo():
	redoList.append(lineList[lineList.keys()[-2]][1])
	lineList[lineList.keys()[-2]][0].clear_points()
	lineList.erase(lineList.keys()[-2])

func redo():
	if redoList.size() > 0:
		for coords in redoList[-1]:
			lineList[UUID][0].add_point(coords)
		redoList.remove_at(redoList.size()-1)
		addingNewLine(1)
	if redoList.size() < 20:
		redoList.remove_at(0)
	
#func erase_points():
	#
	#iterate through all lineNums created and test to see if coordinates are within a radius.
		#for lineNum in range(UUID):
			#var index = 0 #keep track of index as required by remove_point method
			#for point in (lineList[lineNum][0].points):
				#if(event_pos.distance_to(point) < tool_radius):
					#lineList[lineNum][0].remove_point(index)
				#index += 1
	
func _on_tool_selection_pressed_button(extra_arg_0) -> void:
	if(extra_arg_0 == "paint"):
		if(selected_tool == "paint"):
			print("paint tool already selected")
		else:
			selected_tool = "paint"
	elif(extra_arg_0 == "eraser"):
		if(selected_tool == "eraser"):
			print("eraser tool already selected")
		else:
			selected_tool = "eraser"
	elif(extra_arg_0 == "selection"):
		if(selected_tool == "selection"):
			print("selection tool already selected")
		else:
			selected_tool = "selection"
	elif(extra_arg_0 == "shape"):
		if(selected_tool == "shape"):
			print("shape tool already selected")
		else:
			selected_tool = "shape"	
