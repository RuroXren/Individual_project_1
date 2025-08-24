extends Node2D

var text = ""
var HP = 100

var word_list = []

func _ready() -> void:
	load_words()
	$Timer.timeout.connect(_spawn_word)
	$Timer.start(2.0)

func _process(delta: float) -> void:
	$CharacterBody2D/ProgressBar.value = HP

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_BACKSPACE:
			text = text.substr(0,text.length() - 1)
			$Curr_input.text = text
		elif event.keycode == KEY_ENTER:
			text_sub()
		else:
			var char = event.unicode
			if char != 0:
				text += char(char)
				$Curr_input.text = text
		if event.keycode == KEY_TAB: # Debug
			HP -= 1

func text_sub():
	text = ""
	$Curr_input.text = text

func load_words():
	var file = FileAccess.open("res://word_list_ru.txt", FileAccess.READ)
	if file:
		while not file.eof_reached():
			var line = file.get_line()
			if line != "":
				word_list.append(line)
		file.close()

func _spawn_word():
	var scen = preload("res://word.tscn")
	var n_word = scen.instantiate()
	n_word.word = word_list[randi() % word_list.size()]
	
	var spawn_x = randf_range(50, get_viewport_rect().size.x - 50)
	n_word.position = Vector2(spawn_x, -30)
	
	add_child(n_word)

func check(inputed_text):
	pass
