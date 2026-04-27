extends CharacterBody2D

@export var speed := 50
@export var attack_radius := 50
var direction := -1
var gravity := 800
@onready var player = get_tree().get_first_node_in_group("player")

var state := "walk"

func _physics_process(delta: float) -> void:
	match state:
		"attack":
			attacking(delta)
		"walk":
			walking(delta)
	if global_position.distance_to(player.global_position) < 5:
		Global.health -= 1

func attacking(delta):
	velocity.x = 0
	velocity.y += gravity * delta
	
	move_and_slide()
	
	if global_position.distance_to(player.global_position) > attack_radius:
		state = "walk"
		start_walk()

func walking(delta):
	velocity.x = speed * direction
	velocity.y += gravity * delta
	
	move_and_slide()
	
	if is_on_wall():
		direction *= -1
		$Walking.flip_h = direction > 0
	if global_position.distance_to(player.global_position) < attack_radius:
		state = "attack"
		start_attack()
		
func start_attack():
	$Walking.hide()
	$Attacking.show()
	$AnimationPlayer.pause()
	var dir = (player.global_position - global_position)
	$Attacking.flip_h = dir.x > 0
	$AnimationPlayer.play("attack")
	
func start_walk():
	$Walking.show()
	$Attacking.hide()
	$AnimationPlayer.pause()
	$AnimationPlayer.play("snail_walk")
