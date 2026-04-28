extends CharacterBody2D

@export var speed := 50
@export var attack_radius := 30
var direction := -1
var gravity := 800
@onready var player = get_tree().get_first_node_in_group("player")
var can_take_damage := true
@onready var startGame := false

var state := "walk"

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	startGame = true

func _physics_process(delta: float) -> void:
	if player == null or not startGame:
		return
	match state:
		"attack":
			attacking(delta)
		"walk":
			walking(delta)

func attacking(delta):
	velocity.x = 0
	velocity.y += gravity * delta
	
	move_and_slide()
	
	if global_position.distance_to(player.global_position) < attack_radius and can_take_damage and not Global.invincible:
		$attackAudio.play()
		Global.health = max(Global.health - 1, 0)
		can_take_damage = false
		$Timer.start()

	if global_position.distance_to(player.global_position) > attack_radius and can_take_damage:
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

func _on_timer_timeout() -> void:
	can_take_damage = true
