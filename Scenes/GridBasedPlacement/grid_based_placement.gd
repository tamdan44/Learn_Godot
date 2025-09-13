extends Node2D

@onready var base_layer := $Base
@onready var selected_layer := $Selected


var GridSize := 4
var Dic := {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in GridSize:
		for y in GridSize:
			Dic[str(Vector2i(x,y))] = {"Type": "White"}
			base_layer.set_cell(Vector2i(x,y), 0, Vector2i(0,0))
			
	print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)

		
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
	elif event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)
	
	print("Pos: ", base_layer.local_to_map(event.position))
	var tile : Vector2i = base_layer.local_to_map(event.position)
	
	for x in GridSize:
		for y in GridSize:
			selected_layer.erase_cell(Vector2i(x,y))

	if Dic.has(str(tile)):
		selected_layer.set_cell(tile, 1, Vector2i(0,0))




	
