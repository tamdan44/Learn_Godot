extends Control

@export var load_scene: PackedScene
@export var in_time: float = 0.5
@export var fade_in_time: float = 1.5
@export var pause_time: float = 1.5
@export var fade_out_time: float = 0.5
@export var out_time: float = 0.5


@onready var splash_icon: TextureRect = $SplashIconContainer/Icon


func _ready() -> void:
	fade()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_pressed():
		SceneController.instance.change_gui_scene(SceneController.instance.MainMenuScene)

func fade() -> void:
	splash_icon.modulate.a = 0.0
	var tween = self.create_tween()
	tween.tween_interval(in_time)
	tween.tween_property(splash_icon, "modulate:a", 1.0, fade_in_time)
	tween.tween_interval(pause_time)
	tween.tween_property(splash_icon, "modulate:a", 0.0, fade_out_time)
	tween.tween_interval(out_time)
	await tween.finished
	get_tree().change_scene_to_packed(load_scene)
