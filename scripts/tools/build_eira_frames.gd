@tool
extends EditorScript

const SHEET_PATH := "res://assets/characters/CHR-01_Eira.png"
const OUTPUT_PATH := "res://scenes/eira/eira_frames.tres"
const CELL := Vector2i(600, 1400)

# Baris di sheet: 0 depan, 1 belakang, 2 kiri, 3 kanan
const DIRECTIONS := {
	"down": 0,
	"up": 1,
	"left": 2,
	"right": 3,
}
const WALK_ORDER := [0, 1, 2, 1]
const WALK_FPS := 6.0


func _run() -> void:
	var sheet: Texture2D = load(SHEET_PATH)
	if sheet == null:
		push_error("Sheet tidak ditemukan: " + SHEET_PATH)
		return

	var frames := SpriteFrames.new()
	frames.remove_animation("default")

	for dir_name in DIRECTIONS:
		var row: int = DIRECTIONS[dir_name]

		var idle_name: String = "idle_" + dir_name
		frames.add_animation(idle_name)
		frames.set_animation_loop(idle_name, true)
		frames.set_animation_speed(idle_name, 1.0)
		frames.add_frame(idle_name, _make_frame(sheet, 1, row))

		var walk_name: String = "walk_" + dir_name
		frames.add_animation(walk_name)
		frames.set_animation_loop(walk_name, true)
		frames.set_animation_speed(walk_name, WALK_FPS)
		for col in WALK_ORDER:
			frames.add_frame(walk_name, _make_frame(sheet, col, row))

	var err := ResourceSaver.save(frames, OUTPUT_PATH)
	if err != OK:
		push_error("Gagal menyimpan: " + str(err))
		return

	EditorInterface.get_resource_filesystem().scan()
	print("Selesai: ", OUTPUT_PATH)


func _make_frame(sheet: Texture2D, col: int, row: int) -> AtlasTexture:
	var atlas := AtlasTexture.new()
	atlas.atlas = sheet
	atlas.region = Rect2(col * CELL.x, row * CELL.y, CELL.x, CELL.y)
	return atlas
