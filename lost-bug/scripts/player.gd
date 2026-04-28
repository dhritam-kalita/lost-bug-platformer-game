extends CharacterBody2D

@export var GRAVITY := 800
@export var SPEED: int = 300
@export var JUMP_SPEED: int = 400
signal position_changed(pos: Vector2)

var direction := Vector2.ZERO

func _ready() -> void:
	#set default animation to idle
	$AnimatedSprite2D.play("idle")
func _physics_process(delta: float) -> void:
	if not Global.gameOver:
		movement(delta)
		animator()
		position_changed.emit(global_position)
	else:
		collision_mask = 5
		collision_layer = 6

func movement(delta):
	#left and right movement
	direction.x = Input.get_axis("left", "right")
	velocity.x = direction.x * SPEED
	
	#jump logic
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -JUMP_SPEED
	
	#gravity
	velocity.y += GRAVITY * delta
	move_and_slide()
	
func animator():
	if not is_on_floor():
		if velocity.y < 0:
			$AnimatedSprite2D.play("jump")
		else:
			$AnimatedSprite2D.play("fall")
	else:
		if abs(velocity.x) > 0:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")
	
	# flip sprite
	if direction.x != 0:
		$AnimatedSprite2D.flip_h = direction.x < 0
