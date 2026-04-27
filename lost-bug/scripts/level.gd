extends Node2D

func _on_bottom_area_entered(_area: Area2D) -> void:
	Global.gameOver = true
	print("game over")

func _process(delta: float) -> void:
	if Global.gameOver:
		pass
