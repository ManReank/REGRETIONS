extends Node

signal dialogue_started
signal dialogue_line_changed(text: String)
signal dialogue_finished

const INTERACTIONS_PATH: String = "res://data/dialogue/interactions.json"

var dialogue_lines: Array[String] = []
var current_line_index: int = 0
var is_dialogue_active: bool = false

var interaction_data: Dictionary = {}


func _ready() -> void:
	_load_interaction_data()
	InteractionManager.interaction_triggered.connect(_on_interaction_triggered)


func _load_interaction_data() -> void:
	var json_resource: JSON = load(INTERACTIONS_PATH) as JSON
	if json_resource == null:
		push_error("Gagal memuat data dialog: " + INTERACTIONS_PATH)
		return

	var parsed: Variant = json_resource.data
	if parsed is Dictionary:
		interaction_data = parsed
	else:
		push_error("Format data dialog tidak valid (harus berupa objek JSON): " + INTERACTIONS_PATH)


func get_interaction_lines(object_id: String, day: int) -> Array[String]:
	var result: Array[String] = []

	var entry: Variant = interaction_data.get(object_id)
	if not entry is Dictionary:
		return result

	var raw: Variant = entry.get(str(day), entry.get("default", []))
	if raw is Array:
		for line in raw:
			result.append(str(line))

	return result


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
	dialogue_lines = []
	current_line_index = 0

	dialogue_finished.emit()


func _on_interaction_triggered(object_id: String) -> void:
	var lines: Array[String] = get_interaction_lines(object_id, GameManager.current_day)
	if lines.is_empty():
		push_warning("Tidak ada dialog untuk objek: " + object_id)
		return

	start_dialogue(lines)
