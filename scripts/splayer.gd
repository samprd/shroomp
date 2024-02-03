extends CharacterBody2D

@export_range(0.0, 10.0, 0.1) var speed: = 5.0;
@export_range(0.0, 10.0, 0.1) var maxSpeed: = 6.0;
@export_range(0.0, 10.0, 0.1) var jumpForce: = 6.0;
@export_range(0.05, 1.0, 0.01) var friction: = 0.05;

@export_range(0.0, 10.0, 0.1) var gravity: = 3.5;

func _ready():
	speed *= 10;
	maxSpeed *= 10;
	jumpForce *= 20;
	gravity *= 98;

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right");
	
	if direction:
		velocity.x += direction * speed * friction;
	else:
		velocity.x = move_toward(velocity.x, 0, speed * friction);
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta;
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpForce * -1;
	
	if direction == 1:
		velocity.x = clamp(velocity.x, 0, maxSpeed * direction);
	elif direction == -1:
		velocity.x = clamp(velocity.x, maxSpeed * direction, 0);

	move_and_slide()
