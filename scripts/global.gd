extends Node

# global variables
var bg_speed = 25
var loop = 0	   # how many cycles there have been
var high_score = 0
var played = false

var player: AudioStreamPlayer
var effects: AudioStreamPlayer

var button_sfx = preload("res://art/button.mp3")
var good_sfx = preload("res://art/success.mp3")
var bad_sfx = preload("res://art/failed.mp3")

func _ready(): #play music !
	player = AudioStreamPlayer.new()
	player.stream = preload("res://art/background-music.mp3")
	player.autoplay = true    
	add_child(player)
	
	effects = AudioStreamPlayer.new() #plays sound effects globally
	effects.max_polyphony = 3
	add_child(effects)
	
	AudioServer.set_bus_volume_db(0, -20) #set volume to be quieter
	
func button_sound():
	effects.stream = button_sfx
	effects.volume_db = -5
	effects.pitch_scale = 1.1
	effects.play()

func success_sound():
	effects.stream = good_sfx
	effects.volume_db = -10
	effects.pitch_scale = 1
	effects.play()
	
func fail_sound():
	effects.stream = bad_sfx
	effects.volume_db = -10
	effects.pitch_scale = 1.5
	effects.play()
