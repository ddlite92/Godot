extends CanvasLayer


func show_popup():
	visible = true

func hide_popup():
	visible = false

func _on_main_menu_pressed() -> void:
	Game.playerHP = 10
	get_tree().change_scene_to_file("res://main.tscn")
