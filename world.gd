extends Node2D

const SCREEN_W := 1000
const SCREEN_H := 600
const MARGIN := 10
var words_list = ["hello", "boat", "human", "game", "key", "lock", "pizza"]

func _ready():
	$Timer.timeout.connect(_spawn_word)
	$Timer.start(2.0)
	

func _process(_delta):
	$Inp_Dis.text = "ВВОД: " + curr_inp

func _spawn_word():
	var scen = preload("res://word.tscn")
	var w_ins = scen.instantiate()
	
	w_ins.word = words_list[randi() % words_list.size()]
	
	var spawn_pos := Vector2()
	var side = randi() % 4
	match side:
		0:
			spawn_pos = Vector2(randf_range(0, SCREEN_W), -MARGIN)
		1:
			spawn_pos = Vector2(randf_range(0, SCREEN_W),  SCREEN_H + MARGIN)
		2:
			spawn_pos = Vector2(-MARGIN, randf_range(0, SCREEN_H))
		3:
			spawn_pos = Vector2(SCREEN_W + MARGIN, randf_range(0, SCREEN_H))
			
	w_ins.position = spawn_pos
	$WordCont.add_child(w_ins)

var curr_inp := ""

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.unicode >= 16 and event.unicode <= 512:
			curr_inp += char(event.unicode)
		
		if event.keycode == KEY_ENTER:
			_check_w(curr_inp)
			curr_inp = ""
		
		if event.keycode == KEY_BACKSPACE:
			curr_inp = curr_inp.substr(0, curr_inp.length() - 1)

func  _check_w(input: String):
	for word in $WordCont.get_children():
		if word.word.to_lower() == input.to_lower():
			word.queue_free()
			break
