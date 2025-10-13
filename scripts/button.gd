extends Area3D

@onready var  player = get_node("/root/Main/player")
@onready var  light = get_node("/root/Main/light")
@onready var  tv = get_node("/root/Main/Tv")

@onready var in_area_button = false




@onready var audio: AudioStreamPlayer = $Audio

@onready var texty1 = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
		if Input.is_action_just_pressed("interact") && in_area_button:
			light.visible = !light.visible
			audio.play()
			if texty1 == false:
				player.change("")
				$Timer.start()
				



func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		in_area_button = true
		player.label()


func _on_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		in_area_button = false
		player.label()


func _on_timer_timeout() -> void:
	player.change("Dispose the Cans")
	print("Dispose the Cans")
	#tv.tvused = true
	#tv.playtv()
	texty1 = true
	
				
