class_name QandA
extends Node2D
signal solved
signal wrong
signal hide_other_questions(q_and_a) #Preguntar

onready var question := $Question setget ,get_question
onready var answer := $Answer setget ,get_answer

var solve := false
var question_select := false
var answer_select := false

func _ready() -> void:
	question.connect("ques")
	
	pass
