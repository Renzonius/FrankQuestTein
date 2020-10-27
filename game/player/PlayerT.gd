class_name PlayerT
extends KinematicBody2D

export var speed := Vector2(200.0, 200.0)

var object_to_interact:ObjectBook
var can_move := true setget set_can_move

onready var can_interact := false setget set_can_interact


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
		return direction
	
	return Vector2.ZERO


func one_solved() -> void:
	$AnimationPlayer.play("right")

func one_wrong() -> void:
	$AnimationPlayer.play("wrong")
