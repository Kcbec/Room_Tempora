extends Control

onready var text = get_parent().get_node("Dialogue").dialogue_1

var neutral_expression = preload("res://Yahoo/Sprite Male Dark Hair Neu01.png")
var happy_expression = preload("res://Yahoo/Sprite Male Dark Hair Smi01.png")
var sad_expression = preload("res://Yahoo/Sprite Male Dark Hair Sad01.png")
var angry_expression = preload("res://Yahoo/Sprite Male Dark Hair Ang01.png")

var aisling_neutral_expression = preload("res://Lady/sprite female dark hair Neu01.png")
var aisling_angry_expression = preload("res://Lady/sprite female dark hair Ang01.png")
var aisling_annoyed_expression1 = preload("res://Lady/sprite female dark hair Ann01.png")
var aisling_annoyed_expression2 = preload("res://Lady/sprite female dark hair Ann02.png")

var dialogue_index = 0
var finished
var active

var position
var expression

func _ready():
	load_dialogue()
	
func _physics_process(delta):
	if active:
		
		if Input.is_action_just_pressed("ui_accept"):
			if finished == true:
				load_dialogue()
			else:
				$TextBox/Tween.stop_all()
				$TextBox/RichTextLabel.percent_visible = 1
				finished = true 

		if $TextBox/Label.text == "Yahoo":
			$Male.visible = true
			if position == "1":
				$Male.global_position = get_parent().get_node("1").position
			if position == "2":
				$Male.global_position = get_parent().get_node("2").position
			if position == "3":
				$Male.global_position = get_parent().get_node("3").position
			if position == "4":
				$Male.global_position = get_parent().get_node("4").position
				
			if expression == "Happy":
				$Male.texture = happy_expression
			if expression == "Sad":
				$Male.texture = sad_expression
			if expression == "Angry":
				$Male.texture = angry_expression
				
			
				
				
				
		if $TextBox/Label.text == "Aisling":
			$Lady.visible = true
			if position == "1":
				$Lady.global_position = get_parent().get_node("1").position
			if position == "2":
				$Lady.global_position = get_parent().get_node("2").position
			if position == "3":
				$Lady.global_position = get_parent().get_node("3").position
			if position == "4":
				$Lady.global_position = get_parent().get_node("4").position
				
			if expression =="Aisling_angry":
				$Lady.texture = aisling_angry_expression
			if expression =="Aisling_annoyed1":
				$Lady.texture = aisling_annoyed_expression1
			if expression =="Aisling_annoyed2":
				$Lady.texture = aisling_annoyed_expression2
				
		if $Button1.text == "":
			$Button1.visible = false
		else:
			$Button1.visible = true
		if $Button2.text == "":
			$Button2.visible = false
		else:
			$Button2.visible = true
				
func load_dialogue():
	if dialogue_index < text.size():
		active = true
		finished = false
			
		$TextBox.visible = true
		$TextBox/RichTextLabel.bbcode_text = text[dialogue_index]["Text"]
		$TextBox/Label.text = text[dialogue_index]["Name"]
		$Button1.text = text[dialogue_index]["Choices"][0]
		$Button2.text = text[dialogue_index]["Choices"][1]
		
		expression = text[dialogue_index]["Expression"]
		position = text[dialogue_index]["Position"]
			
		$TextBox/RichTextLabel.percent_visible = 0
		$TextBox/Tween.interpolate_property(
			$TextBox/RichTextLabel, "percent_visible", 0, 1, 2,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
			)
		$TextBox/Tween.start()
	else:
		$TextBox.visible = false
		finished = true
		active = false
	dialogue_index += 1
			
func _on_Tween_tween_completed(_object, _key):
	finished = true



func _on_Button1_pressed():
	if $Button1.text == "Why not?":
		$Button1.text = ""
		$Button2.text = ""
		text = get_parent().get_node("Dialogue").after_choice_1
		dialogue_index = 0
		load_dialogue()


func _on_Button2_pressed():
	if $Button2.text == "Why do I do what?":
		$Button1.text = ""
		$Button2.text = ""
		text = get_parent().get_node("Dialogue").after_choice_2
		dialogue_index = 0
		load_dialogue()
