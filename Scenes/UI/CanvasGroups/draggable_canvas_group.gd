extends CanvasGroup

var dragging := false
var drag_offset := Vector2.ZERO

func _ready():
	set_process_input(true) 	#Make sure the group can get input events

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			#loop thru all chidren
			for child in get_children():
				if child is Sprite2D:
					if child.get_rect().has_point(to_local(event.position)):
						dragging = true
						drag_offset = position - event.position
						return
		else:
			dragging = false

	elif event is InputEventMouseMotion and dragging:
		position = event.position + drag_offset
