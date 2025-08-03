extends Node2D

var game = preload("res://scenes/main.tscn")

func _ready():
	if Global.played:
		update()
		Global.played = false
		

func _on_play_pressed() -> void:
	Global.button_sound()
	get_tree().change_scene_to_packed(game)
	

func update():
	if Global.high_score < Global.loop:
		Global.high_score = Global.loop
	
	$score.text = "score: %d loops" % [Global.loop]
	$hiscore.text = "hi-score: %d loops" % [Global.high_score]
