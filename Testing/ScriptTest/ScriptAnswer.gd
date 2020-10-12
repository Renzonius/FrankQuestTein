extends Node

class_name Answer

var completed: bool setget _set_answer_completed, _get_answer_completed
var answer_type: String
var score: int 
export var id_answer: int 

func _set_answer_completed(result : bool):
	completed = result
func _get_answer_completed():
	return completed

func _hide_answer():
	pass

func _add_score():
	pass

func _answer_completed():
	pass




func _on_Area2D_body_entered(body: Node) -> void:
	body = get_parent().get_node("Player")
	body._set_player_near_answer(true)
	body._set_answer_obj(self)


func _on_Area2D_body_exited(body: Node) -> void:
	body = get_parent().get_node("Player")
	body._set_player_near_answer(false)
