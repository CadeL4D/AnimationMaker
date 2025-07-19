extends Control

@onready var AddButton = $VBoxContainer/Add
@onready var PlayButton = $VBoxContainer/Watch
@onready var SaveButton = $VBoxContainer/Save
@onready var FileSave = $dirSave

func _ready() -> void:
	AddButton.pressed.connect(add_button_clicked)
	PlayButton.pressed.connect(play_button_clicked)
	SaveButton.pressed.connect(save_button_clicked)

func add_button_clicked():
	
	var count = num_files_in("user://")
	print(count)
	count = ("0"+str(count)) if len(str(count)) == 1 else count
	get_viewport().get_texture().get_image().save_png("user://image"+str(count)+".png")
	var rect = ColorRect.new()
	rect.color = Color.BLACK
	get_parent().add_child(rect)
	
func play_button_clicked():
	get_images("user://")
			
func save_button_clicked():
	FileSave.show()

func num_files_in(path):
	var files = []
	var dir = DirAccess.open(path)
	if dir:
		return len((dir.get_files()))

func get_images(path):
	var images = []
	var dir = DirAccess.open(path)
	if dir:
		print(dir.get_files())
		for i in dir.get_files():
			var image = Image.load_from_file(path+str(i))
			images.append(image)
	return images
			

func _on_dir_save_file_selected(path: String) -> void:
	const GIFExporter = preload("res://gdgifexporter/exporter.gd")
	# load quantization module that you want to use
	const MedianCutQuantization = preload("res://gdgifexporter/quantization/median_cut.gd")
	# load your image from png file
	
	# remember to use this image format when exporting
	
	var png_images = get_images("user://")
	# initialize exporter object with width and height of gif canvas
	var exporter = GIFExporter.new(png_images[0].get_width(), png_images[0].get_height())
	
	# write image using median cut quantization method and with one second animation delay
	for img in png_images:
		img.convert(Image.FORMAT_RGBA8)
		exporter.add_frame(img, 1, MedianCutQuantization)

	# when you have exported all frames of animation you, then you can save data into file
	# open new file with write privlige
	
	var file: FileAccess = FileAccess.open(path, FileAccess.WRITE)
	# save data stream into file
	file.store_buffer(exporter.export_file_data())
	# close the file
	file.close()
