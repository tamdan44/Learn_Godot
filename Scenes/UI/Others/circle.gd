extends Node2D

const circle_radius: float = 50.0
const circle_color: Color = Color.RED

const line_width: float = 5.0
const line_color: Color = Color.YELLOW

var screen_center: Vector2
var end_point := Vector2(0, -circle_radius)
var time := 0.0

func _ready() -> void:
	get_screen_center()
	
func get_screen_center():
	screen_center = get_viewport().size/2

func _draw() -> void:
	draw_circle(screen_center, circle_radius, circle_color, true, 0.0, true)
	draw_line(screen_center, screen_center + end_point, line_color, line_width, true)

func _process(delta: float) -> void:
	time += delta
	end_point = circle_radius * Vector2(cos(time), sin(time))
	queue_redraw()
