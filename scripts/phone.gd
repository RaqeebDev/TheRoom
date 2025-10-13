extends Node3D

@onready var emmision: MeshInstance3D = $emmision
@onready var  player = get_node("/root/Main/player")
@onready var  tv = get_node("/root/Main/Tv")
@onready var ring: AudioStreamPlayer = $ring
@onready var ended: AudioStreamPlayer = $ended

@onready var call2nd = false


@onready var in_areaphone = false
@onready var used = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && in_areaphone :
	
		ring.stop()
		ended.play()
		emmision.visible = false
		

			
			
				
		
		if used == false:
			player.change("")	
			
			if call2nd == false:
				call2nd = true
			elif call2nd == true:
				$Timer.start()
				used = true
				
			
			

func playy():
	emmision.visible = true
	#print("yesphone")
	ring.play()
	#print("playing")


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		in_areaphone = true
		player.label()


func _on_area_3d_body_exited(body: Node3D) -> void:
	in_areaphone = false
	player.label()


func _on_timer_timeout() -> void:
	tv. beforephonetv()
	player.done()
	used = true
