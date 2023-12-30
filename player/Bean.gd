extends CharacterBody3D


const  SPEED = 3
const JUMP_VELOCITY = 6
var bonusspeed = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var mousex = 0

func _init():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY+bonusspeed
		$hyppy.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("moveL", "moveR", "moveF", "moveB")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * (SPEED+bonusspeed), SPEED/3)
		velocity.z = move_toward(velocity.z, direction.z * (SPEED+bonusspeed), SPEED/3)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED/3)
		velocity.z = move_toward(velocity.z, 0, SPEED/3)

	move_and_slide()
	
	if position.y < -300:
		position = Vector3(0,0,0)

func _input(event):
	if event is InputEventMouseMotion:
		mousex = event.relative.x
	if event.is_action("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("run"):
		bonusspeed = 4
	if event.is_action_released("run"):
		bonusspeed = 0

func _process(delta):
	rotate_y(mousex/-1000)
	mousex = 0
