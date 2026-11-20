
extends Node

signal dialogue_started
signal dialogue_line_changed(text: String)
signal dialogue_finished

var dialogue_lines: Array[String] = []
var current_line_index: int = 0
var is_dialogue_active: bool = false


func _ready() -> void:
	InteractionManager.interaction_triggered.connect(_on_interaction_triggered)


func start_dialogue(lines: Array[String]) -> void:
	if lines.is_empty():
		return

	dialogue_lines = lines
	current_line_index = 0
	is_dialogue_active = true

	dialogue_started.emit()
	dialogue_line_changed.emit(dialogue_lines[current_line_index])


func next_line() -> void:
	if not is_dialogue_active:
		return

	current_line_index += 1

	if current_line_index >= dialogue_lines.size():
		finish_dialogue()
		return

	dialogue_line_changed.emit(dialogue_lines[current_line_index])


func finish_dialogue() -> void:
	is_dialogue_active = false
	dialogue_lines.clear()
	current_line_index = 0

	dialogue_finished.emit()


func _on_interaction_triggered(object_id: String) -> void:
	match object_id:
		"mirror":
			start_dialogue([
				"Eira berdiri di hadapan sebuah cermin.",
				"Pantulan itu terlihat begitu asing.",
                "Eira: ...Apakah itu benar-benar aku?"
			])
