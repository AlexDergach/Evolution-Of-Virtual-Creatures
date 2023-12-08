extends CharacterBody3D

#Movement Variables
var speed = 2
var accel = 10

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var NavTarget = get_node("/root/Node3D/Marker3D")

func _physics_process(delta):
	
	var direction = Vector3()
	
	#Calculates positions
	nav.target_position = NavTarget.global_position
	
	#Calculates the path once you give your nav agent a target
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()
