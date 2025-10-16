extends StaticBody3D

@onready var plane: MeshInstance3D = $Plane_002
@onready var  player = get_node("/root/Main/player")
@onready var light: SpotLight3D = $SpotLight3D
@onready var sound: AudioStreamPlayer3D = $soundtv
@onready var  phone = get_node("/root/Main/phone")
@onready var  int_phone = false

var playing: bool = false
var is_changed: bool = false
var default_material: Material = null
var in_area_tv = false

var tvused = false
var beforephone = false


func beforephonetv():
	beforephone = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if Input.is_action_just_pressed("interact") && in_area_tv == true   && beforephone == true:
		
		if not is_changed:
			playtv()
			
		else:
			
			$knocktimer.start()
			plane.material_override = default_material  # revert to original
			sound.stop()
			light.visible = !light.visible
			is_changed = false
			if tvused == true :
				player.change("")
				$Timer.start()
				


func _on_area_3d_body_entered(body: Node3D) -> void :
	
	if body.is_in_group("player")  && beforephone == true :
		
		in_area_tv = true
		player.label()


func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player") && beforephone == true:
		in_area_tv = false
		player.label()
		
		
func playtv():
			var new_material = StandardMaterial3D.new()
			new_material.albedo_texture = load("res://Assets/textures/images.jpg")
			plane.material_override = new_material
			sound.play() 
			light.visible = !light.visible
			
			
			#if int_phone:
				#
			
			# Enable emission
			new_material.emission_enabled = true
			new_material.emission = Color(1,1,1) # base color multiplier
			new_material.emission_energy_multiplier = 0.2
			new_material.emission_texture = load("res://Assets/textures/images.jpg")
			
			
		
			
			
	
			is_changed = true		




func _on_timer_timeout() -> void:
	
	tvused = false
	
	#phone.playy()


func _on_knocktimer_timeout() -> void:
	$"../end".show()
	$"Avoid-horror-268576".play()
	
