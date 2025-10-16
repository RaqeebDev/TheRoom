extends Node3D

@onready var wall: CSGBox3D = $Walls/wall
@onready var wall2: CSGBox3D = $Walls/wall2
@onready var wall3: CSGBox3D = $Walls/wall3
@onready var wall4: CSGBox3D = $Walls/wall4
@onready var wall5: CSGBox3D = $Walls/wall5
@onready var wall6: CSGBox3D = $Walls/wall6
@onready var floor: CSGBox3D = $Walls/floor
@onready var ceil: CSGBox3D = $Walls/ceil

@onready var wallhaunted = preload("res://materials/wallhaunted.tres")
@onready var wallreal = preload("res://materials/wallreal.tres")
@onready var floorhaunted = preload("res://materials/floorhaunted.tres")
@onready var floorreal = preload("res://materials/floorreal.tres")
@onready var used = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$fader.show()
	
	await get_tree().create_timer(45.0).timeout
	$light.visible = ! $light.visible
	$bone.play()
	await get_tree().create_timer(0.6).timeout
	$light.visible = ! $light.visible
	$bone.play()
	
	
	
	
	


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("interact") && used == false:
		$fader/Label2.hide()
		$fader/Label.hide()
		$fader/AnimationPlayer.play("fade_out")
		
		$fader/Timer.start()
		used = true
		
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func donemain():
	$Tv.playtv()
	$AudioStreamPlayer.play()
	wall.material_override = wallhaunted
	wall2.material_override = wallhaunted
	wall3.material_override = wallhaunted
	wall4.material_override = wallhaunted
	wall5.material_override = wallhaunted
	wall6.material_override = wallhaunted
	floor.material_override = floorhaunted
	ceil.material_override = floorhaunted
	$donetimer.start()
	


func _on_timer_timeout() -> void:
	$fader.queue_free()


func _on_donetimer_timeout() -> void:
	$player.breath()
	wall.material_override = wallreal
	wall2.material_override = wallreal
	wall3.material_override = wallreal
	wall4.material_override = wallreal
	wall5.material_override = wallreal
	wall6.material_override = wallreal
	floor.material_override = floorreal
	ceil.material_override = floorreal
	
	
	
