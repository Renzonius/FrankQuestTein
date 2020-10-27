extends Node2D

var question_group : Array
var num_questions : int 
var answer_group : Array
var num_answers : int
onready var timer_clock := $Timers.get_child(0)
var seconds : int

export (Array, PackedScene) var preguntas





var answe_dictionary = {
	"answe_color": ["green","purple","orange"],
	"answe_mathematics": ["16","14","-1","1","50","-23","115","-233","121","-535"],
	"answe_symbols": ["1","2","3","4","5"]
}

var question_dictionary = {
	"question_color": ["blueYellow", "blueRed", "redYellow"],
	"question_mathematics": {
		"16": ["2x8","8+8","32-16"],
		"14": ["2x7","7+7","54-40"],
		"-1": ["1x-1","-1+0","367-368"],
		"1": ["1x1","1+0", "86-85"] },
	"question_symbols": ["1","2","3","4","5"]
}

#func _random_answer():
#	for answer in answer_group:
#
#		pass


func _ready() -> void:
	$Player.connect("contestada_una_pregunta",self,"descontar_una_pregunta")
	seconds = timer_clock._get_seconds()
	question_group = get_tree().get_nodes_in_group("quiz")
	num_questions = question_group.size()
	print(num_questions)
	answer_group = get_tree().get_nodes_in_group("responses")
	num_answers = answer_group.size()



func descontar_una_pregunta():
	num_questions -= 1
	print(num_questions)
	if(num_questions == 0):
		print("Nivel completado")




func _lose():
	if(seconds <= 0):
		print("PERDISTE")
	pass



func _winner(): #Cuando el jugador gana el nivel
	if(num_questions == 0):
		print("GANASTE")
	pass







