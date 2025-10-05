extends StaticBody3D

@onready var plane: MeshInstance3D = $Plane_002
@onready var  player = get_node("/root/Main/player")
@onready var light: SpotLight3D = $SpotLight3D


var is_changed: bool = false
var default_material: Material = null




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
		else:
			plane.material_override = default_material  # revert to original


func _on_area_3d_body_entered(body: Node3D) -> void:
	player.label()


func _on_area_3d_body_exited(body: Node3D) -> void:
	player.label()
