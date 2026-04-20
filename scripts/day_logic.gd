class_name DayLogic extends Node

signal on_hour_passed(hour:int, pm:bool)
signal on_day_finished


@export var first_hour :int = 8
@export var last_hour :int = 6
var hour :int
var is_past_midnight :bool = false
const MIDNIGHT_TIME :int = 12

func _ready() -> void:
	hour = first_hour
	await get_tree().process_frame
	on_hour_passed.emit(hour, true)


func _on_hour_timer_timeout() -> void:
	hour = (hour + 1) % MIDNIGHT_TIME
	on_hour_passed.emit(hour, hour >= 8)
	if hour == 0:
		is_past_midnight = true
	
	if is_past_midnight and hour >= last_hour:
		on_day_finished.emit()


func get_total_time() -> float:
	var time_before_midnight := MIDNIGHT_TIME - first_hour
	var total_time = time_before_midnight + last_hour
	return total_time * $HourTimer.wait_time
