extends Node

class_name Question


var completed: bool setget _set_question_completed, _get_question_completed
onready var sprite = get_node("Sprite")
var question_type: String
#var position: Vector2
var is_select: bool setget _set_is_select
export var id_question: int

func _set_is_select(select : bool):
	is_select = select

func _set_question_completed(result : bool):
	completed = result
func _get_question_completed():
	return completed

func _show_question():
	print("la pregunta ", id_question," se muestra")
#	sprite.set_modulate(Color(1,255,1,1)) 
	sprite.visible = true

func _hide_question():
	print("la pregunta ",id_question," se esconde")
#	sprite.set_modulate(Color(1,241,255,1))
	sprite.visible = false
	




func _on_Area2D_body_entered(body: Node) -> void:
	body = get_parent().get_node("Player")
	body._set_player_near_question(true)
	body._set_question_obj(self)
	


func _on_Area2D_body_exited(body: Node) -> void:
	body = get_parent().get_node("Player")
	body._set_player_near_question(false)
