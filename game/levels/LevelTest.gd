extends Node

export(Array, PackedScene) var questions_and_answers

var total_q_and_a := 0
var final_questions_and_answers := []
var player: PlayerT

#----Timer----
var timer: TimerScript

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer = get_node("Timers")
	timer.connect("finished", self, "end_time")
	player = get_node("Player")
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
	player.one_solved()
	total_q_and_a -= 1
	if total_q_and_a == 0:
		$Player.set_can_move(false)
		$AnimationPlayer.play("win")
		print("GANASTE EL NIVEL")


func end_time() ->void:
	$Player.set_can_move(false)
	print("PERDISTE")

func hide_questions(q_and_a = null) -> void:
	get_tree().call_group("questions_answers", "deselect_question", q_and_a)
