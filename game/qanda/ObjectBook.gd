class_name ObjectBook
extends StaticBody2D

signal question_selected
signal answer_selected

export var text := "Texto"
export var is_question := false

var animation_frame 

var is_showing := false setget set_is_showing

onready var player_in_range := false

func set_is_showing(value: bool) -> void:
	is_showing = false


func _ready() -> void:
	$Panel/TextEdit.text = text
	_select_animation_book() #Seleccionamos la animacion correcta 


func _on_PlayerInteraction_body_entered(body: Node) -> void:
	player_in_range = true

func _on_PlayerInteraction_body_exited(body: Node) -> void:
	player_in_range = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select") and player_in_range and not is_showing:
		if is_question:
			is_showing = true
			emit_signal("question_selected")
#			$AnimationPlayer.play("show")#--------------TESTEANDOOO
			$AnimationPlayer2.play("open_book")
		else:
			emit_signal("answer_selected")


func _select_animation_book():
		match get_parent().name:
			"QandAOne":
				animation_frame = "open_book"
			"QandATwo":
				animation_frame = "open_book_Q2"
			"QandAThree":
				animation_frame = "open_book_Q3"
			_:
				print("Animation Fail")

