extends CharacterBody3D

var speed
var cameraRotaion = 0.005
var gravity = 7

#For pivot of Camera
@onready var head = $Helmet
@onready var camera = $Helmet/Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_process(true)

#Esc key to quit game
func _process(delta):
	if Input.is_action_pressed("key_exit"):
		get_tree().quit()
	
#Mouse events
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * cameraRotaion)
		camera.rotate_x(-event.relative.y * cameraRotaion)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 5.0
	
	# Handle Sprint.
	if Input.is_action_pressed("sprint"):
		speed = 9.0
	else:
		speed = 5.0

	# Get the input and handle the movement
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Continue movement motions while still in the air
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	# FOV For speed changes
	var velocity_clamped = clamp(velocity.length(), 0.5, 9.0 * 2)
	var fov = 75 + 4 * velocity_clamped
	camera.fov = lerp(camera.fov, fov, delta * 8.0)
	
	move_and_slide()


