extends Node2D

@onready var run_timer = $stage_timer

func _ready() -> void:
	start_runner()

func _process(delta: float) -> void:
	$ui/time.text = "time left: %02d:%02d" % [int(run_timer.time_left / 60), int(run_timer.time_left) % 60]
	
	if Input.is_action_just_pressed("debug"):
		start_runner()
	
func _on_stage_timer_timeout() -> void:
	# start boss fight 
	$devil.health = 500 + Global.loop * 100
	$ui/devil_health.max_value = 500 + Global.loop * 100
	$devil.start()
	
	# animations
	var tw = create_tween().set_parallel(true)
	tw.tween_property($ui.get_node("devil_health"), "position:y", 700, 0.75).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tw.tween_property($devil, "position:x", 130, 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	
	# edit world speed
	Global.bg_speed = 25
	$platform_spawn.spawn_speed = 2.5
	$platform_spawn.runner = false
	$cat.SPEED = 500
	
	
func start_runner():
	# controlls speed of runner
	$platform_spawn.runner = true
	run_timer.start(40 - (Global.loop * 5))
	
	# run_timer.start(5)
	var tw = create_tween().set_parallel(true)
	tw.tween_property($devil, "position:x", -300, 0.5).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	tw.tween_property($ui.get_node("devil_health"), "position:y", 780, 0.75).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	var speed_tw = create_tween().set_parallel(true)
	speed_tw.tween_property(Global, "bg_speed", 60, run_timer.wait_time - 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	speed_tw.tween_property($platform_spawn, "spawn_speed", 1.3, run_timer.wait_time - 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
	speed_tw.tween_property($cat, "SPEED", 750, run_timer.wait_time - 1).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN_OUT)
