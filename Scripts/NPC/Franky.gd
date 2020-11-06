class_name EnemyNpc
extends KinematicBody2D

signal player_was_captured


onready var blackboard = $Blackboard
onready var behavior_tree = $BehaviorTree


export var speed = 400




func _ready() -> void:
	owner.connect("all_q_and_a_completed", self, "_qandaCompleted")
	owner.connect("npc_wake_up_and_patrol", self, "_wake_up_franky")
	owner.connect("patrol_time_over", self, "_chase_start")
	owner.connect("all_time_over", self, "_finished_time")
	blackboard.set("idle", true)
	blackboard.set("patrol_time_finished", false)
	blackboard.set("q_and_a_completed", false)
	blackboard.set("player_captured", false)
	blackboard.set("time_over", false)
	blackboard.set("wake_up", false)
	blackboard.set("chase_time_finished", false)
	

func _qandaCompleted():
	blackboard.set("q_and_a_completed", true)

func _finished_time():
	blackboard.set("time_over", true)

func _wake_up_franky():
	blackboard.set("idle", false)
	blackboard.set("wake_up", true)
	blackboard.set("patrol_time_finished", false)
	blackboard.set("chase_time_finished", true)

func _chase_start():
	blackboard.set("patrol_time_finished", true)
	blackboard.set("chase_time_finished", false)


func _process(delta: float) -> void:
	update_behavior_tree()
	
func update_behavior_tree() -> void:
	behavior_tree.run(self, blackboard, false)


func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("player_was_captured")
		blackboard.set("player_captured", true)
