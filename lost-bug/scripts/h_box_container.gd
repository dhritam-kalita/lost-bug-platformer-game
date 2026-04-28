extends HBoxContainer

@onready var hearts = get_children()
@onready var gone_hearts = preload("res://kenney_ui-pack/Vector/Red/check_round_grey_circle.svg")

func _process(_delta: float) -> void:
	update_hearts()

func update_hearts():
	for i in hearts.size():
		if i < Global.health:
			hearts[i].visible = true
		else:
			hearts[i].texture = gone_hearts


func _on_touch_screen_button_pressed() -> void:
	Global.gameOver = true
