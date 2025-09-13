class_name SceneController extends Node

@export var world_2d: Node2D
@export var gui: Control

var current_2d_scene: Node2D
var current_gui_scene: Control
static var instance: SceneController

# preloads
var MainMenuScene = preload("res://Scenes/UI/UIbasic/main_menu.tscn")
var SplashScreenScene = preload("res://Scenes/UI/UIanimation/splash_screen.tscn")
var GridScene = preload("res://Scenes/CrissCrossGrid/criss_cross_grid.tscn")


func _ready() -> void:
	SceneController.instance = self
	change_gui_scene(SplashScreenScene)

# ----------------------
# Public API
# ----------------------
func change_2d_scene(scene: PackedScene, delete := true, keep_running := false) -> void:
	current_2d_scene = _switch_scene(current_2d_scene, world_2d, scene, delete, keep_running)

func change_gui_scene(scene: PackedScene, delete := true, keep_running := false) -> void:
	current_gui_scene = _switch_scene(current_gui_scene, gui, scene, delete, keep_running)

# ----------------------
# Internal helper
# ----------------------
func _switch_scene(current: Node, parent: Node, new_scene: PackedScene, delete: bool, keep_running: bool) -> Node:
	if current:
		if delete:
			current.queue_free()
		elif keep_running:
			current.visible = false
		else:
			parent.remove_child(current)

	var new_instance = new_scene.instantiate()
	parent.add_child(new_instance)
	return new_instance
