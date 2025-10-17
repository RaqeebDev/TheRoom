extends OmniLight3D

# Flicker settings
@export var min_energy: float = 0.5
@export var max_energy: float = 2.0
@export var flicker_speed: float = 0.05  # seconds between flickers

func _ready():
	randomize()
	flicker_light()

func flicker_light() -> void:
	light_energy = randf_range(min_energy, max_energy)
	await get_tree().create_timer(flicker_speed).timeout
	flicker_light()
