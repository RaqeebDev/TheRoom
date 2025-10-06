extends StaticBody3D

@onready var plane: MeshInstance3D = $Plane_002
@onready var  player = get_node("/root/Main/player")
@onready var light: SpotLight3D = $SpotLight3D



var is_changed: bool = false
var default_material: Material = null
var in_area = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("interact"):
		
		if not is_changed:
			var new_material = StandardMaterial3D.new()
			new_material.albedo_texture = load("res://Assets/textures/images.jpg")
			plane.material_override = new_material
			light.visible = !light.visible
			
			# Enable emission
			new_material.emission_enabled = true
			new_material.emission = Color(1,1,1) # base color multiplier
			new_material.emission_energy_multiplier = 1.2
			new_material.emission_texture = load("res://Assets/textures/images.jpg")
			
			is_changed = true
		else:
			plane.material_override = default_material  # revert to original
			light.visible = !light.visible
			is_changed = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	in_area = true
	player.label()


func _on_area_3d_body_exited(body: Node3D) -> void:
	in_area = false
	player.label()
