extends StaticBody3D

#@onready var opened = false
#@onready var in_areadoor = false
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#
#
#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("interact") && in_areadoor == true:
		#if opened == false:
			#$AnimationPlayer.play("open")
			#opened = true
		#else:
			#$AnimationPlayer.play("close")	
			#opened = false
#
#
#func _on_turn_on_area_body_entered(body: Node3D) -> void:
	#if body.is_in_group("player"):
		#in_areadoor = true
#
#
#func _on_turn_on_area_body_exited(body: Node3D) -> void:
	#if body.is_in_group("player"):
		#in_areadoor = false
