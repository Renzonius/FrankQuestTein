class_name PlayerT
extends KinematicBody2D

export var speed := Vector2(1.0, 1.0)

var object_to_interact:ObjectBook
var can_move := true setget set_can_move

var score: int = 0 setget set_score, get_score

onready var can_interact := false setget set_can_interact
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

func set_score(value: int)->void:
	score = value

func get_score()-> int:
	return score

func set_can_move(value: bool) -> void:
	can_move = value

func set_can_interact(value: bool) -> void:
	can_interact = value


func _physics_process(delta: float) -> void:
	var mov = speed * get_direction().normalized()
	
	move_and_slide(mov, Vector2.ZERO)


func get_direction() -> Vector2:
	if can_move:
		var direction := Vector2(
			Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
			Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		)
		
		if direction != Vector2.ZERO:
			animation_tree.set("parameters/idle/blend_position", direction)
			animation_tree.set("parameters/walk/blend_position", direction)
			animation_tree.set("parameters/won/blend_position", direction)
			animation_tree.set("parameters/lose/blend_position", direction)
			animation_state.travel("walk")
		else:
			animation_state.travel("idle")
		return direction
	
	
	return Vector2.ZERO


func one_solved() -> void:
	$AnimationPlayer.play("right")

func one_wrong() -> void:
	$AnimationPlayer.play("wrong")
