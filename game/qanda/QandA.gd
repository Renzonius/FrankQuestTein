class_name QandA
extends Node2D
signal solved
signal wrong
signal hide_other_questions(q_and_a)

onready var question := $Question setget ,get_question
onready var answer := $Answer setget ,get_answer

var solved := false
var question_selected := false
var answer_selected := false

func _ready() -> void:
	question.connect("question_selected", self, "_question_selected")
	answer.connect("answer_selected", self, "_answer_selected")

func get_question() -> Node:
	return question

func get_answer() -> Node:
	return answer

func set_question_position(value: Vector2) -> void:
	question.global_position = value

func set_answer_position(value: Vector2) -> void:
	answer.global_position = value

func deselect_question(q_and_a) -> void:
	if not solved and question_selected and self.name != q_and_a.name:
		$Question.set_is_showing(false)
		question_selected = false
#		$Question/AnimationPlayer.play("hide")
		$Question/AnimationPlayer2.play("close_book")

func _question_selected() -> void:
	question_selected = true
	emit_signal("hide_other_questions", self)

func _answer_selected() -> void:
	if question_selected and not solved:
		solved = true
		emit_signal("solved")
	else:
		emit_signal("wrong")
