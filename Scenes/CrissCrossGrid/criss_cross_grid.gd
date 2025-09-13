extends Node2D


@onready var square_top_layer := $SquareTopLayer
@onready var square_bot_layer := $SquareBotLayer
@onready var iso_layer := $IsoLayer

@export var GridSize : int
@export var GridPixelSize : int = 128

var tileset_id := 6
var top_left_tile := Vector2i(0,1)
var top_right_tile := Vector2i(1,0)
var bot_left_tile := Vector2i(1,1)
var bot_right_tile := Vector2i(0,0)

var TileDict := {}
var Picece_Set: Array = []

func add_seleceted_tile(value):
	if not Picece_Set.has(value):
		Picece_Set.append(value)


func _ready() -> void:

			
	# loop through square layers and set triangles
	for x in GridSize:
		for y in GridSize:
			if x%2 == y%2:
				square_top_layer.set_cell(Vector2i(x,y), tileset_id, top_left_tile)
				square_bot_layer.set_cell(Vector2i(x,y), tileset_id, bot_right_tile)
				
				if y%2==0:
					TileDict[str(Vector2i(x,y)) + str(Vector2i(x/2,y))] = {"Tile": top_left_tile, "Color": "white"}
					TileDict[str(Vector2i(x,y)) + str(Vector2i(x/2,y+1))] = {"Tile": bot_right_tile, "Color": "white"}
				else:
					
					TileDict[str(Vector2i(x,y)) + str(Vector2i((x-1)/2,y))] = {"Tile": top_left_tile, "Color": "white"}
					TileDict[str(Vector2i(x,y)) + str(Vector2i((x+1)/2,y+1))] = {"Tile": bot_right_tile, "Color": "white"}

			else:
				square_top_layer.set_cell(Vector2i(x,y), tileset_id, top_right_tile)
				square_bot_layer.set_cell(Vector2i(x,y), tileset_id, bot_left_tile)
				
				if y%2==0:
					TileDict[str(Vector2i(x,y)) + str(Vector2i((x+1)/2,y))] = {"Tile": top_right_tile, "Color": "white"}
					TileDict[str(Vector2i(x,y)) + str(Vector2i((x-1)/2,y+1))] = {"Tile": bot_left_tile, "Color": "white"}
				else:
					TileDict[str(Vector2i(x,y)) + str(Vector2i(x/2,y))] = {"Tile": top_right_tile, "Color": "white"}
					TileDict[str(Vector2i(x,y)) + str(Vector2i(x/2,y+1))] = {"Tile": bot_left_tile, "Color": "white"}


func _process(delta: float) -> void:
	pass


func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos = event.position
	
		var square_tile : Vector2i = square_top_layer.local_to_map(square_top_layer.to_local(mouse_pos))
		var iso_tile : Vector2i = iso_layer.local_to_map(iso_layer.to_local(mouse_pos))
		select_triangles(square_tile, iso_tile)
	

func select_triangles(square_tile: Vector2i, iso_tile: Vector2i) -> void:
	var key := str(square_tile) + str(iso_tile)
	if TileDict.has(key):
		add_seleceted_tile(key)
		if _is_top_layer(TileDict[key]["Tile"]):
			square_top_layer.set_cell(square_tile, tileset_id, TileDict[key]["Tile"], 1)
		else:
			square_bot_layer.set_cell(square_tile, tileset_id, TileDict[key]["Tile"], 1)
	print(Picece_Set)

func _is_top_layer(tile_coords: Vector2i) -> bool:
	if tile_coords.x == tile_coords.y:
		return false
	return true
