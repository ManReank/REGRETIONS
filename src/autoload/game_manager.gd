
extends Node

signal day_started(day: int)
signal day_ended(day: int)
signal game_finished

const TOTAL_DAYS: int = 7

var current_day: int = 1
var is_game_finished: bool = false


func start_new_game() -> void:
	current_day = 1
	is_game_finished = false

	day_started.emit(current_day)


func end_day() -> void:
	if is_game_finished:
		return

	day_ended.emit(current_day)

	if current_day >= TOTAL_DAYS:
		is_game_finished = true
		game_finished.emit()
		return

	current_day += 1
	day_started.emit(current_day)
