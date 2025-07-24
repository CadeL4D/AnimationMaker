extends Control

signal pressedButton
signal widthBrush
@onready var widthslider = $VBoxContainer/HBoxContainer/HSlider
@onready var WidthNumber = $VBoxContainer/HBoxContainer/WidthNumber
@onready var Width = $VBoxContainer


func _process(delta: float) -> void:
	if Width.is_visible_in_tree() == true:
		WidthNumber.text = str(int(widthslider.value))

func _on_pressed(extra_arg_0: String) -> void:
	pressedButton.emit(extra_arg_0)
	if extra_arg_0 == "paint" or extra_arg_0 == "eraser":
		Width.show()



func _on_h_slider_gui_input(event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		Width.hide()
		widthBrush.emit(widthslider.value)
