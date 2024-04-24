extends KinematicBody

var speed
export var normal_speed = 10
export var run_speed = 30
export var crouch_speed = 3
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sensitivity = 0.3

onready var head = $Head
onready var camera = $Head/Camera
onready var cshape = $CollisionShape
onready var mesh = $MeshInstance

onready var stand_cshape = preload("res://assets/Standing_Cshape.tres")
onready var stand_mesh = preload("res://assets/Standing_Mesh.tres")
onready var crouch_cshape = preload("res://assets/Crouching_Cshape.tres")
onready var crouch_mesh = preload("res://assets/Crouching_Mesh.tres")

var velocity = Vector3()
var camera_x_rotation = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))

		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	
	if Input.is_action_pressed("sprint") and is_on_floor():
		speed = run_speed
	elif Input.is_action_pressed("crouch") and is_on_floor():
		speed = crouch_speed
		head.translation.y = 1
		cshape.translation.y = 1
		cshape.shape = crouch_cshape
		mesh.translation.y = 1
		mesh.mesh = crouch_mesh
	else:
		speed = normal_speed
		head.translation.y = 2.5
		cshape.translation.y = 1.5
		cshape.shape = stand_cshape
		mesh.translation.y = 1.5
		mesh.mesh = stand_mesh

	var movement_vector = Vector3()
	if Input.is_action_pressed("movement_forward"):
		movement_vector -= head_basis.z
	if Input.is_action_pressed("movement_backward"):
		movement_vector += head_basis.z
	if Input.is_action_pressed("movement_left"):
		movement_vector -= head_basis.x
	if Input.is_action_pressed("movement_right"):
		movement_vector += head_basis.x

	movement_vector = movement_vector.normalized()

	velocity = velocity.linear_interpolate(movement_vector * speed, acceleration * delta)
	velocity.y -= gravity

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power

	velocity = move_and_slide(velocity, Vector3.UP)
