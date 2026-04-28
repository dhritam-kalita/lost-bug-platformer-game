extends Control

func _ready() -> void:
	$gameOver.play()
	$AudioStreamPlayer.play()
#replay
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")

#main menu
func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
#exit
func _on_button_3_pressed() -> void:
	get_tree().quit()
