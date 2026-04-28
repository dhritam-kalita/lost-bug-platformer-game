extends Node2D

func _ready() -> void:
	Global.health = 3
	Global.gameOver = false
	Global.invincible = true
	
	$AudioStreamPlayer.play()
	
	await get_tree().create_timer(1).timeout
	Global.invincible = false
	
	get_tree().get_nodes_in_group("player")

func _process(_delta: float) -> void:
	if Global.health <= 0 and not Global.gameOver:
		Global.gameOver = true
	
	if Global.gameOver:
		$gameOverSFX.playing = true
		await get_tree().create_timer(1).timeout
		$AudioStreamPlayer.stop()
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_bottom_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.gameOver = true
