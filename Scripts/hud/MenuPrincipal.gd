extends Control

func _ready():
	get_node("HandL/AnimatedSprite2").play("run")
	get_node("HandR/AnimatedSprite").play("run")


func _on_play_pressed():
	get_tree().change_scene("res://Assets/Scenes/Levels/Level1.tscn")
	


func _on_exit_pressed():
	get_tree().quit()
