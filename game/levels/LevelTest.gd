extends Node

signal timer_update(lvl_max_time)
signal update_score(score)
signal npc_wake_up_and_patrol
signal all_q_and_a_completed
signal patrol_time_over
signal all_time_over

export(Array, PackedScene) var questions_and_answers

const Winscreen = preload ("res://Assets/Scenes/Screens/Win_level.tscn")
const lose_screen = preload ("res://Assets/Scenes/Screens/Lose.tscn")

var total_q_and_a := 0
var final_questions_and_answers := []
var player: PlayerT
var npc_franky : EnemyNpc

export var patrol_time_npc = 10 
export var chase_time_npc = 15

#----Timer----
var timer: TimerScript
export var lvl_max_time = 60
export var timer_start_npc = 50
var time_elapsed = 0

var in_level : int
var name_level : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match self.name:
		"Level1":
			in_level = 0
			name_level = "res://Assets/Scenes/Levels/Level1.tscn"
		"Level2":
			in_level = 1
			name_level = "res://Assets/Scenes/Levels/Level2.tscn"
		"Level3":
			in_level = 2
			name_level = "res://Assets/Scenes/Levels/Level3.tscn"
		"Level4":
			 in_level = 3
			 name_level = "res://Assets/Scenes/Levels/Level4.tscn"
			
#	timer = get_node("Timers")
#	timer.connect("finished", self, "end_time")
	
	player = get_node("Player")
	npc_franky = get_node("Franky")
	npc_franky.connect("player_was_captured", self, "_defeated_player")
	total_q_and_a = $Questions.get_child_count()
	select_random_q_and_a()
	for i in range(total_q_and_a):
		var new_q_and_a: QandA = final_questions_and_answers[i].instance()
		add_child(new_q_and_a)
		new_q_and_a.set_question_position($Questions.get_child(i).global_position)
		new_q_and_a.set_answer_position($Answers.get_child(i).global_position)
		new_q_and_a.connect("solved", self, "q_and_a_solved")
		new_q_and_a.connect("wrong", self, "q_and_a_wrong")
		new_q_and_a.connect("hide_other_questions", self, "hide_questions")


func select_random_q_and_a() -> void:
	randomize()
	while final_questions_and_answers.size() < total_q_and_a:
		var rand := int(rand_range(0, questions_and_answers.size()))
		if not questions_and_answers[rand] in final_questions_and_answers:
			final_questions_and_answers.append(questions_and_answers[rand])

func q_and_a_wrong() -> void:
	player.one_wrong()

func q_and_a_solved() -> void:
	var win = Winscreen.instance()
	win.select_level_load = in_level
	player.one_solved()
	total_q_and_a -= 1
	player.set_score(player.get_score()+ 10)
	npc_franky.set_speed(npc_franky.get_speed() + 10)
	emit_signal("update_score", player.get_score())
	if total_q_and_a == 0:
		emit_signal("all_q_and_a_completed") #Señal que se conecta al npc
		player.set_score(player.get_score() + 10 * lvl_max_time )
		emit_signal("update_score", player.get_score())
		$Player.set_can_move(false)
		$Timer.stop()
		$Player.animation_state.travel("won")
		add_child(win)
#		print("GANASTE EL NIVEL")

func hide_questions(q_and_a = null) -> void:
	get_tree().call_group("questions_answers", "deselect_question", q_and_a)


func _on_Timer_timeout() -> void:
	emit_signal("timer_update",lvl_max_time)
	if lvl_max_time >0:
		lvl_max_time -= 1
		if lvl_max_time <= timer_start_npc:
			if patrol_time_npc > 0:
				emit_signal("npc_wake_up_and_patrol") #comieza a patrullar 
				patrol_time_npc -=1
#				print("Tpatrulla ",patrol_time_npc)
			elif patrol_time_npc <= 0:
				emit_signal("patrol_time_over") #comienza a perseguir
				chase_time_npc -=1
#				print("Tpersecucion ",chase_time_npc)
				if chase_time_npc <=0: #si termina el tiempo de persecucion
					patrol_time_npc = 2
					chase_time_npc = 2
	else:
		emit_signal("all_time_over")
		_defeated_player()


	
func _defeated_player():
	var lose = lose_screen.instance()
	lose.name_level_restart = name_level
	$Player.set_can_move(false)
	$Timer.stop()
	$Player.animation_state.travel("lose")
	add_child(lose)
#	print("PERDISTE")
	
	#AGREGAR ANIMACION DE PERDER
	#SUBMENU
	#-vOLVER A INTENTAR
	#-IR AL MENU PRINCIPAL
	
	
	
	
