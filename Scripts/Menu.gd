extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Project.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")
	
func _on_preset_pressed():
	get_tree().change_scene_to_file("res://Scenes/preset.tscn")

func _on_quit_pressed():
	get_tree().quit()
