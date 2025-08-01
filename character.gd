extends CharacterBody2D

var HP = 100
var MP = 0

func _ready():
	add_to_group("Player")
func _process(delta):
	$ProgressBar.value = HP

func _on_area_2d_area_entered(area: Area2D) -> void:
	HP -= 1
	
