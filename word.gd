extends CharacterBody2D

var speed = 60
var word = ""
var P = null

func _ready() -> void:
	add_to_group("Word")
	$Label.text = word
	P = get_tree().get_first_node_in_group("Player")
func _physics_process(delta: float) -> void:
	if P:
		var dir = global_position.direction_to(P.global_position)
		velocity = dir * speed
		move_and_collide(velocity * delta)
