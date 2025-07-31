extends CharacterBody2D

var word: String = ""
var player_ref: Node2D = null
var speed: int = 50

func _ready():
	$Label.text = word
	
	player_ref = get_tree().get_first_node_in_group("Player")

func _physics_process(delta):
	if player_ref:
		var direction = global_position.direction_to(player_ref.global_position)
		velocity = direction * speed
		move_and_collide(velocity * delta)
