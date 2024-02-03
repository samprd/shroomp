extends Camera2D

@export var cameraOffset: = Vector2(0, 0);
@export var player: CharacterBody2D;

func _process(delta):
	position.x = player.position.x + cameraOffset.x;
	position.y = player.position.y + cameraOffset.y;

func shake(duration = 0.1, frequency = 15, amplitude = 4, priority = 0) -> void:
	$ScreenShakes.start(duration, frequency, amplitude, priority);
