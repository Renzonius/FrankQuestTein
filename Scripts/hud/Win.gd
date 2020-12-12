extends CanvasLayer

var levels : Array = ["res://Assets/Scenes/Levels/Level2.tscn","res://Assets/Scenes/Levels/Level3.tscn","res://Assets/Scenes/Levels/Level4.tscn","res://game/hub/Menu.tscn" ]
var select_level_load : int 
var name_level_restart : String

func _on_sig_nivel_pressed():
	get_tree().change_scene(levels[select_level_load])


func _on_salir_pressed():
	get_tree().quit()


func _on_Menu_again_pressed():
	get_tree().change_scene("res://game/hub/Menu.tscn")


func _on_quit_pressed():
	get_tree().quit()


func _on_restart_pressed():
	get_tree().change_scene(name_level_restart)
