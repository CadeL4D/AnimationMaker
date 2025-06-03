extends Control

@onready var AddButton = $VBoxContainer/Add
@onready var PlayButton = $VBoxContainer/Watch
@onready var SaveButton = $VBoxContainer/Save

func _ready() -> void:
	AddButton.pressed.connect(add_button_clicked)
	PlayButton.pressed.connect(play_button_clicked)
	SaveButton.pressed.connect(save_button_clicked)

func add_button_clicked():
	var count = list_files_in_directory("user://frames")
	print(count)
	get_viewport().get_texture().get_image().save_png("user://frames/image"+str(count)+".png")
	
func play_button_clicked():
	print("playing")
	
func save_button_clicked():
	print("saved")

func list_files_in_directory(path):
	var files = []
	var dir = DirAccess.open(path)
	print(dir)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while true:
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				print("Found file: " + file_name)
				files.append(file_name)
			file_name = dir.get_next()
	return len(files)
