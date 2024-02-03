extends CharacterBody2D

@export var speed: = 500.0;
@export var maxSpeed: = 625.0;
@export var jumpForce: = 1450.0;
@export var slip: = 0.05;
@onready var animationPlayer: = $AnimationPlayer;

@export var gravityScale: = 3.5;
var gravity = gravityScale * ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("move_left", "move_right");
	$Sprite2D.flip_h = direction == -1;
	
	if direction:
		animationPlayer.play("walk");
		velocity.x += direction * speed * slip;
	else:
		if is_on_floor():
			animationPlayer.play("idle");
		velocity.x = move_toward(velocity.x, 0, speed * slip);
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta;
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animationPlayer.play("jump");
		velocity.y = jumpForce * -1;
	
	if direction == 1:
		velocity.x = clamp(velocity.x, 0, maxSpeed * direction);
	elif direction == -1:
		velocity.x = clamp(velocity.x, maxSpeed * direction, 0);

	move_and_slide()
