extends Control

@onready var day_label: Label = $DayLabel
@onready var interaction_hint: Label = $InteractionHint


func _ready() -> void:
	GameManager.day_started.connect(_on_day_started)
	InteractionManager.nearby_object_changed.connect(_on_nearby_object_changed)
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)

	interaction_hint.hide()
	_on_day_started(GameManager.current_day)


func _on_day_started(day: int) -> void:
	day_label.text = "Hari %d" % day


func _on_nearby_object_changed(object: Area2D) -> void:
	if object == null:
		interaction_hint.hide()
		return

	var action_text: String = str(object.get("interaction_text"))
	interaction_hint.text = "[E] " + action_text
	interaction_hint.show()


func _on_dialogue_started() -> void:
	interaction_hint.hide()


func _on_dialogue_finished() -> void:
	_on_nearby_object_changed(InteractionManager.nearby_object)
