
extends Node

signal room_state_changed(day: int, state: Dictionary)

var current_room_state: Dictionary = {}


const ROOM_STATES: Dictionary = {
	1: {
		"condition": "normal",
		"visible_objects": [],
		"visible_characters": []
	},
	2: {
		"condition": "normal",
		"visible_objects": ["baby_clothes"],
		"visible_characters": ["child"]
	},
	3: {
		"condition": "normal",
		"visible_objects": ["baby_clothes", "knife"],
		"visible_characters": ["child", "husband"]
	},
	4: {
		"condition": "conflict",
		"visible_objects": ["baby_clothes", "knife"],
		"visible_characters": ["child", "husband"]
	},
	5: {
		"condition": "corrupted",
		"visible_objects": ["mirror"],
		"visible_characters": ["past_self"]
	},
	6: {
		"condition": "confrontation",
		"visible_objects": [],
		"visible_characters": ["past_self", "child", "husband"]
	},
	7: {
		"condition": "resolution",
		"visible_objects": [],
		"visible_characters": []
	}
}


func _ready() -> void:
	GameManager.day_started.connect(_on_day_started)


func _on_day_started(day: int) -> void:
	if not ROOM_STATES.has(day):
		return

	current_room_state = ROOM_STATES[day].duplicate(true)
	room_state_changed.emit(day, current_room_state)


func get_current_room_state() -> Dictionary:
	return current_room_state.duplicate(true)
