extends StaticBody3D

@onready var plane: MeshInstance3D = $Plane_002
@onready var light: SpotLight3D = $SpotLight3D
@onready var sound: AudioStreamPlayer3D = $soundtv

# TV state
var is_on: bool = false

# Flicker/random timing settings
@export var min_interval: float = 0.01   # min seconds before changing state
@export var max_interval: float = 0.05   # max seconds before changing state

# Original material
var default_material: Material = null

func _ready() -> void:
	default_material = plane.material_override
	randomize()
	_schedule_next_toggle()

func _schedule_next_toggle() -> void:
	# Wait random time then toggle TV
	var wait_time = randf_range(min_interval, max_interval)
	await get_tree().create_timer(wait_time).timeout
	_toggle_tv()
	_schedule_next_toggle()

func _toggle_tv() -> void:
	if is_on:
		# Turn OFF
		plane.material_override = default_material
		sound.stop()
		light.visible = false
		is_on = false
	else:
		# Turn ON
		var new_material = StandardMaterial3D.new()
		new_material.albedo_texture = load("res://Assets/textures/images.jpg")
		new_material.emission_enabled = true
		new_material.emission = Color(1,1,1)
		new_material.emission_energy_multiplier = 0.2
		new_material.emission_texture = load("res://Assets/textures/images.jpg")
		plane.material_override = new_material

		sound.play()
		light.visible = true
		is_on = true
