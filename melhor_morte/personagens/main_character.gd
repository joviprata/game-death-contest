extends CharacterBody2D

@export var move_speed :float = 200

# parameters/idle/blend_position

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@export var starting_direction :Vector2 = Vector2(0, -1)

@onready var all_interactions = []
@onready var interact_label = $InteractionComponent/InteractLabel

@export var inv: Inv
@onready var sprite = $Sprite2D

var on_interaction_area = false
var morto = false

func _ready():
	update_animation_parameters(starting_direction)

func _physics_process(_delta: float) -> void:
	# Add the gravity.
	var input_direction = Vector2(
		Input.get_action_strength("right_p1") - Input.get_action_strength("left_p1"),
		Input.get_action_strength("down_p1") - Input.get_action_strength("up_p1")
	)
	if not morto:
		update_animation_parameters(input_direction)
		
		velocity = input_direction * move_speed
		
		move_and_slide()
		pick_new_state()

func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)

func pick_new_state():
	if (velocity!= Vector2.ZERO):
		state_machine.travel("Walk", false)
	else:
		state_machine.travel("Idle", false)

func _process(_delta: float) -> void:
	if Input.get_action_strength("interaction_p1") && on_interaction_area:
		sprite.flip_v = -1
		morto = true
		animation_tree.active = false
		interact_label.text = "e morreu"
		

# funções de interação
func _on_interaction_area_area_entered(area: Area2D) -> void:
	all_interactions.insert(0, area)
	on_interaction_area = true
	update_interactions()


func _on_interaction_area_area_exited(area: Area2D) -> void:
	all_interactions.erase(area)
	on_interaction_area = false
	update_interactions()



func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""
