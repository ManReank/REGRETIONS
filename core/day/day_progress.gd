extends Node

const DAYS_PATH: String = "res://data/days/days.json"
const SLEEP_OBJECT_ID: String = "bed"
const LOCKED_DIALOGUE_KEY: String = "bed_locked"

var days_data: Dictionary = {}
var interacted_objects: Array[String] = []


func _ready() -> void:
	_load_days_data()
	GameManager.day_started.connect(_on_day_started)
	InteractionManager.interaction_triggered.connect(_on_interaction_triggered)


func _load_days_data() -> void:
	var json_resource: JSON = load(DAYS_PATH) as JSON
	if json_resource == null:
		push_error("Gagal memuat data hari: " + DAYS_PATH)
		return

	var parsed: Variant = json_resource.data
	if parsed is Dictionary:
		days_data = parsed
	else:
		push_error("Format data hari tidak valid: " + DAYS_PATH)


func get_required_objects(day: int) -> Array[String]:
	var result: Array[String] = []

	var entry: Variant = days_data.get(str(day))
	if not entry is Dictionary:
		return result

	var raw: Variant = entry.get("required_objects", [])
	if raw is Array:
		for object_id in raw:
			result.append(str(object_id))

	return result


func get_missing_objects() -> Array[String]:
	var missing: Array[String] = []
	for object_id in get_required_objects(GameManager.current_day):
		if not interacted_objects.has(object_id):
			missing.append(object_id)
	return missing


func can_end_day() -> bool:
	return get_missing_objects().is_empty()


func _on_day_started(_day: int) -> void:
	interacted_objects.clear()


func _on_interaction_triggered(object_id: String) -> void:
	print("[DEBUG] DayProgress menerima: ", object_id,
		" | hari=", GameManager.current_day,
		" | sudah=", interacted_objects,
		" | kurang=", get_missing_objects())
	if object_id == SLEEP_OBJECT_ID:
		_try_sleep()
		return

	if not interacted_objects.has(object_id):
		interacted_objects.append(object_id)


func _try_sleep() -> void:
	if not can_end_day():
		var lines: Array[String] = DialogueManager.get_interaction_lines(
			LOCKED_DIALOGUE_KEY, GameManager.current_day
		)
		DialogueManager.start_dialogue(lines)
		return

	GameManager.end_day()
