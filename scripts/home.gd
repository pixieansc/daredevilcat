extends Node2D

var game = preload("res://scenes/main.tscn")

func _ready():
	print("SDFD")

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(game)
