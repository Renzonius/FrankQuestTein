tool
extends KinematicBody2D

class_name Player

var question_select : Node2D setget _set_question_select
var answer_select : Node2D setget _set_answer_select
var score: int setget _set_score, _get_score
var player_near_question: bool setget _set_player_near_question
var player_near_answer : bool setget _set_player_near_answer
export (int) var speed = 300
var velocity = Vector2()

var question_obj: Node2D setget _set_question_obj
var answer_obj: Node2D setget _set_answer_obj

func _set_question_obj(question : Node2D):
	question_obj = question

func _set_answer_obj(answer : Node2D):
	answer_obj = answer


func _set_question_select(question : Node2D):
	question_select = question

func _set_answer_select(answer : Node2D):
	answer_select = answer

func _set_score(ponts : int):
	score += ponts
func _get_score():
	return score

func _set_player_near_answer(answer : bool):
	player_near_answer = answer

func _set_player_near_question(inside : bool):
	player_near_question = inside


func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	_move()
	if(Input.is_action_just_pressed("ui_accept") and player_near_question):
		if not (question_obj._get_question_completed()): #SOLO si la pregunta NO esta completa
			_interact_question()
	if(Input.is_action_just_pressed("ui_accept") and player_near_answer and question_select != null):
		if not (answer_obj._get_answer_completed()): #SOLO si la respuesta NO esta completa
			_choose_answer()
	












func _interact_question():
	if (question_select == null):
		_choose_question()
	elif(question_select == question_obj):
		_deselect_question()
	elif(question_select != question_obj):
#		_deselect_question()
		print("Es distinta")
#		_choose_question()








func _choose_question():
	_set_question_select(question_obj)
	question_obj._set_is_select(true)
	question_obj._show_question()









func _deselect_question():
	_set_question_select(null)
	question_obj._set_is_select(false)
	question_obj._hide_question()
#	_set_question_obj(null)


func _choose_answer():
	_set_answer_select(answer_obj)
	if(question_select.id_question == answer_select.id_answer):
		_set_score(answer_select.score)
		question_obj._set_question_completed(true)
		answer_obj._set_answer_completed(true)
		print("son correctas")
	else:
		#DISMINUIR EL TIEMPO DEL CONTADOR
		print("son distintas")
	
	_set_question_select(null)
	_set_question_obj(null)
	_set_answer_obj(null)
	_set_answer_select(null)


func _defeat():
	pass

func _move():
	get_input()
	velocity = move_and_slide(velocity)

func _happy_time():
	pass




func _on_Area2D_body_entered(body: Node) -> void:
	pass
#	body = get_parent().get_node("OBJQuestion")
#	print("Este es el objeto: ",body)
#	question_obj = body
#	print("Este es el objeto Question_obj: ",question_obj)
#	if(body.id_question != question_obj.id_question):
#		question_obj = body
#		print("entro")
	
