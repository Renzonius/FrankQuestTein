class_name EnemyNpc
extends KinematicBody2D

signal player_was_captured


onready var blackboard = $Blackboard
onready var behavior_tree = $BehaviorTree

onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

var nav_map: TileMap
var nav_map_array : Array
var player : KinematicBody2D


var magic_AStar : NavMap
var my_position: Vector2
var position_player : Vector2
var path #Camino a seguir

var MOV_SPEED := 200
var can_move := true setget set_can_move
const POINT_RADIUS := 2

#export var speed = 400
export var size_tiles : Vector2 #Tañamo de los tiles para el calculo en node_to_pose

onready var timer_end : = $TimerToChase


func set_can_move(new_value : bool ) -> void:
	can_move = new_value
func get_can_move()->bool:
	return can_move

func _ready() -> void:
	player = owner.get_node("Player")
	nav_map = owner.get_node("NavMap")
	nav_map_array = nav_map.get_used_cells() # posiciones/tiles validos
	magic_AStar = NavMap.new(nav_map_array, size_tiles) # creamos el objeto A*
	
#	chase_state.connect("take_position_player", self,"_time_to_move")
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


func _physics_process(delta: float) -> void:
	if path and can_move:
		var target = path[0]
		var direction: Vector2 = (target - position).normalized()
		
		position += direction * MOV_SPEED * delta
		
		 
		if position.distance_to(target) < POINT_RADIUS:
			path.remove(0)
				
			if path.size() == 0:
				path = null
		
		if direction != Vector2.ZERO :
			animation_tree.set("parameters/idle/blend_position", direction)
			animation_tree.set("parameters/patrol/blend_position", direction)
			animation_tree.set("parameters/persuit/blend_position", direction)
			
			if blackboard.get("chase_time_finished") and not blackboard.get("patrol_time_finished"):
				animation_state.travel("patrol")
			elif blackboard.get("patrol_time_finished") and not blackboard.get("chase_time_finished"):
				animation_state.travel("persuit") 
	else: 
		animation_state.travel("idle")
			 





func _qandaCompleted():
	set_can_move(false)
	blackboard.set("q_and_a_completed", true)

func _finished_time():
	set_can_move(false)
	blackboard.set("time_over", true)

func _wake_up_franky():
	set_can_move(true)
#	MOV_SPEED = 200
	blackboard.set("idle", false)
	blackboard.set("wake_up", true)
	blackboard.set("patrol_time_finished", false)
	blackboard.set("chase_time_finished", true)

func _chase_start():
#	MOV_SPEED = 250
	blackboard.set("patrol_time_finished", true)
	blackboard.set("chase_time_finished", false)


func _process(delta: float) -> void:
	update_behavior_tree()
	
func update_behavior_tree() -> void:
	behavior_tree.run(self, blackboard, false)

func _time_to_move():
#	position_player = player.global_position
	my_position = self.position
	path = magic_AStar.find_path(my_position,position_player)
	if path:
		path.remove(0)
#	print("El camino arrecorrer",path)
#	print("Cantidad de pasos ", path.size())



func _on_Area2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		emit_signal("player_was_captured")
		blackboard.set("player_captured", true)



## Timer que maneja la persecucion 
func _on_TimerToChase_timeout() -> void:
	if blackboard.get("patrol_time_finished") and not blackboard.get("chase_time_finished") and not blackboard.get("player_captured") and not blackboard.get("time_over") and not blackboard.get("player_captured") and not blackboard.get("time_over") and not blackboard.get("q_and_a_completed"):
		position_player = player.global_position
		_time_to_move()


## Timer que maneja la patrulla 
func _on_TimerToPatrol_timeout() -> void:
	if not blackboard.get("patrol_time_finished") and  blackboard.get("chase_time_finished") and not blackboard.get("player_captured") and not blackboard.get("time_over") and not blackboard.get("q_and_a_completed"):
		position_player = _choose_random_cell()
		_time_to_move()

# Metodo que elige una posicion al azar para la patrulla del npc
func _choose_random_cell() -> Vector2: 
	var result : Vector2
	result = nav_map_array[randi()%nav_map_array.size()]
	result = magic_AStar.node_to_pos(result)
	print("este es la celda ",result)
	return result
