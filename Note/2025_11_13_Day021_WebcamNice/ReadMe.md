I am wondering how hard it is to use the asset of wow export in Godot to teach how to make video fan base of World of Warcraft.  
Without the question of the legallity, just is it possible and how hard it is ?    
  
The idea would be to create mini fan game with kids.  
Like a fan video made in the past.  



I think that godot dont have the option to use the camera in the editor.
But outside it kind of works.

After vibing a bit I succeed to ahve the image but they are still some issue (flickering and green pixel)
Window is or will be supported in the git comment in future version. (need a bit of cleaning or something like that)
I need to try it on the raspberry pi to see if I have an image.  (If I do, I have to heaven)

``` gdscript
extends Control

@export var camera_view: TextureRect
@export var debug_label: Label

var feed: CameraFeed
var cam_tex: CameraTexture
var connected: bool = false
var lost_frames_timer: float = 0.0
var last_reconnect_time: int = 0

const LOST_FRAME_TIMEOUT := 5.0    # seconds without frames before reconnect
const RECONNECT_COOLDOWN := 10.0   # minimum delay between reconnects

func _ready() -> void:
	debug_label.text = "📷 Initializing camera system...\n"
	CameraServer.camera_feeds_updated.connect(_on_camera_feeds_updated)
	CameraServer.monitoring_feeds = true
	_log("🔍 Searching for available camera feeds...")
	_on_camera_feeds_updated()


func _on_camera_feeds_updated() -> void:
	var feeds: Array = CameraServer.feeds()
	if feeds.is_empty():
		_log("❌ No camera feeds detected. Please connect a camera (MiraBox).")
		return

	for i in range(feeds.size()):
		_log("   • [%d] %s" % [i, feeds[i].get_name()])

	# 🎯 Pick MiraBox feed or first available
	feed = null
	for f in feeds:
		if "mirabox" in f.get_name().to_lower():
			feed = f
			break
	if feed == null:
		feed = feeds[0]
		_log("⚠️ No MiraBox feed found — using first available: %s" % feed.get_name())
	else:
		_log("🎯 Found MiraBox feed: %s" % feed.get_name())

	# 🛑 Deactivate if currently active
	if feed.is_active():
		_log("🛑 Deactivating feed before format change...")
		feed.set_active(false)
		await get_tree().process_frame

	# 📋 Get formats and skip MJPEG
	var formats: Array = feed.get_formats()
	if formats.is_empty():
		_log("⚠️ No formats reported by device.")
		return

	_log("📋 Available formats:")
	for i in range(formats.size()):
		var f: Dictionary = formats[i]
		_log("   • [%d] %dx%d %s" % [
			i,
			f.get("width", 0),
			f.get("height", 0),
			f.get("format", "unknown")
		])

	var selected_index: int = 0
	var fallback_index: int = 0

	for i in range(formats.size()):
		var fmt: String = str(formats[i].get("format", ""))
		var fmt_lower := fmt.to_lower()
		if "yuyv" in fmt_lower or "rgb" in fmt_lower:
			selected_index = i
			break
		elif "mjpeg" in fmt_lower or "motion-jpeg" in fmt_lower:
			fallback_index = i  # used only if no YUYV/RGB found

	# 🧩 Use fallback if necessary
	var selected_fmt: String = str(formats[selected_index].get("format", ""))
	if not ("yuyv" in selected_fmt.to_lower() or "rgb" in selected_fmt.to_lower()):
		_log("⚠️ Only MJPEG formats found — falling back to index %d" % fallback_index)
		selected_index = fallback_index

	var fmt_name: String = str(formats[selected_index].get("format", "unknown"))
	_log("🧩 Selecting format index %d (%s)" % [selected_index, fmt_name])

	var ok: bool = feed.set_format(selected_index, {})
	if ok:
		_log("✅ Format set successfully.")
	else:
		_log("⚠️ Failed to set format — driver may use default.")

	# 🎥 Activate feed
	feed.set_active(true)
	await get_tree().process_frame

	if feed.is_active():
		_log("✅ Feed active.")
		cam_tex = CameraTexture.new()
		cam_tex.camera_feed_id = feed.get_id()
		camera_view.texture = cam_tex
		connected = true
		lost_frames_timer = 0.0
	else:
		_log("❌ Feed activation failed — check permissions or device availability.")
		connected = false


func _process(delta: float) -> void:
	if connected and cam_tex:
		var w: int = cam_tex.get_width()
		var h: int = cam_tex.get_height()

		if w > 32 and h > 32: # ignore transient 0x0 frames
			lost_frames_timer = 0.0
			debug_label.text = "✅ Receiving frames: %dx%d" % [w, h]
		else:
			lost_frames_timer += delta
			debug_label.text = "⏳ Waiting for frames... %.1fs" % [lost_frames_timer]

			if lost_frames_timer > LOST_FRAME_TIMEOUT \
			and (Time.get_ticks_msec() - last_reconnect_time) > (RECONNECT_COOLDOWN * 1000):
				last_reconnect_time = Time.get_ticks_msec()
				_log("⚠️ No frames for %.1fs — attempting to refresh..." % LOST_FRAME_TIMEOUT)
				await _refresh_feed()
				lost_frames_timer = 0.0


func _refresh_feed() -> void:
	if not feed:
		_log("⚠️ No feed to refresh — rescanning feeds.")
		_on_camera_feeds_updated()
		return

	_log("♻️ Refreshing camera feed...")
	feed.set_active(false)
	await get_tree().process_frame
	feed.set_active(true)
	await get_tree().process_frame

	if feed.is_active():
		_log("✅ Feed reactivated successfully.")
	else:
		_log("❌ Feed reactivation failed — will retry later.")
		connected = false


func _log(msg: String) -> void:
	print(msg)
	debug_label.text += msg + "\n"


```

https://github.com/godotengine/godot/pull/49763
https://github.com/godotengine/godot/pull/106094
https://github.com/godotengine/godot/pull/105734


Camera Feed:    
https://github.com/shiena/godot-camerafeed-demo   



Apparently there is a way on Linux, outside of the editor:
https://github.com/users/EloiStree/projects/23/views/1?pane=issue&itemId=127570796&issue=EloiStree%7CHelloGodotRemoteControlHub%7C15


Now I need to check on Android Editor and on my Raspberry Pi 5 if I can make it works.



-----------

This code work on the Quest3 but you need a shader to parse the color

```
extends Node
Godot Engine v4.5.stable.official.876b29033 - https://godotengine.org
Vulkan 1.3.295 - Forward Mobile - Using Device #0: Qualcomm - Adreno (TM) 740

   • [0] 1 | FRONT
   • [1] 50 | BACK
   • [2] 51 | BACK
🎥 Selecting camera index 2: 51 | BACK
📋 Available formats:
   • [0] 320x240 YUV_420_888
   • [1] 640x480 YUV_420_888
   • [2] 800x600 YUV_420_888
   • [3] 1280x960 YUV_420_888
🧩 Selecting format index 3 (YUV_420_888)
✅ Format set successfully.
📏 Selected resolution: 1280x960
🔍 Searching for available camera feeds...
   • [0] 1 | FRONT
   • [1] 50 | BACK
   • [2] 51 | BACK
🎥 Selecting camera index 2: 51 | BACK
🛑 Deactivating feed before format change...
❌ Feed activation failed — check permissions or device availability.
📋 Available formats:
   • [0] 320x240 YUV_420_888
   • [1] 640x480 YUV_420_888
   • [2] 800x600 YUV_420_888
   • [3] 1280x960 YUV_420_888
🧩 Selecting format index 3 (YUV_420_888)
✅ Format set successfully.
📏 Selected resolution: 1280x960
✅ Feed active.
🖥️ Camera view resized to fit 1120x840 (aspect 1.33)
Scene Undo: Set format_id

```


``` gdscript
extends Control

@export var camera_view: TextureRect
@export var debug_label: Label
@export var cam_id: int = 0
@export var format_id: int = 0
## list of cameras found 
@export var found_camera_debug_text: String
## formats found in the selected camera
@export var found_camera_format_debug_text: String
@export var selected_width: int
@export var selected_height: int

signal on_camera_list_updated(camera_found: Array[String])
signal on_camera_selected_format_updated(camera_selected_format_found: Array[String])

var feed: CameraFeed
var cam_tex: CameraTexture
var connected: bool = false
var lost_frames_timer: float = 0.0
var last_reconnect_time: int = 0

const LOST_FRAME_TIMEOUT := 5.0    # seconds without frames before reconnect
const RECONNECT_COOLDOWN := 10.0   # minimum delay between reconnects

func _ready() -> void:
	debug_label.text = "📷 Initializing camera system...\n"
	CameraServer.camera_feeds_updated.connect(_on_camera_feeds_updated)
	CameraServer.monitoring_feeds = true
	_log("🔍 Searching for available camera feeds...")
	_on_camera_feeds_updated()

func _on_camera_feeds_updated() -> void:
	var feeds: Array = CameraServer.feeds()
	var camera_names: Array[String] = []

	if feeds.is_empty():
		_log("❌ No camera feeds detected. Please connect a camera (MiraBox).")
		found_camera_debug_text = "No camera feeds detected."
		emit_signal("on_camera_list_updated", [])
		return

	for i in range(feeds.size()):
		var name: String = str(feeds[i].get_name())
		camera_names.append(name)
		_log("   • [%d] %s" % [i, name])

	found_camera_debug_text = "\n".join(camera_names)
	emit_signal("on_camera_list_updated", camera_names)

	# 🎯 Choose camera
	if cam_id >= feeds.size():
		cam_id = 0
	_log("🎥 Selecting camera index %d: %s" % [cam_id, feeds[cam_id].get_name()])
	feed = feeds[cam_id]

	# 🛑 Deactivate feed before setting format
	if feed.is_active():
		_log("🛑 Deactivating feed before format change...")
		feed.set_active(false)
		await get_tree().process_frame

	# 📋 Get formats
	var formats: Array = feed.get_formats()
	var format_strings: Array[String] = []

	if formats.is_empty():
		_log("⚠️ No formats reported by device.")
		found_camera_format_debug_text = "No formats available."
		emit_signal("on_camera_selected_format_updated", [])
		return

	_log("📋 Available formats:")
	for i in range(formats.size()):
		var f: Dictionary = formats[i]
		var fmt_text := "%dx%d %s" % [f.get("width", 0), f.get("height", 0), f.get("format", "unknown")]
		format_strings.append(fmt_text)
		_log("   • [%d] %s" % [i, fmt_text])

	found_camera_format_debug_text = "\n".join(format_strings)
	emit_signal("on_camera_selected_format_updated", format_strings)

	# Pick format
	if format_id >= formats.size():
		format_id = 0

	var fmt_name: String = str(formats[format_id].get("format", "unknown"))
	_log("🧩 Selecting format index %d (%s)" % [format_id, fmt_name])

	var ok: bool = feed.set_format(format_id, {})
	if ok:
		_log("✅ Format set successfully.")
	else:
		_log("⚠️ Failed to set format — driver may use default.")

	# 📏 Fetch width and height of the selected format
	if formats.size() > format_id:
		var selected_format: Dictionary = formats[format_id]
		selected_width = int(selected_format.get("width", 0))
		selected_height = int(selected_format.get("height", 0))
		_log("📏 Selected resolution: %dx%d" % [selected_width, selected_height])
	else:
		selected_width = 0
		selected_height = 0
		_log("⚠️ Invalid format index; width and height set to 0.")

	# 🎥 Activate feed
	feed.set_active(true)
	await get_tree().process_frame

	if feed.is_active():
		_log("✅ Feed active.")
		cam_tex = CameraTexture.new()
		cam_tex.camera_feed_id = feed.get_id()
		camera_view.texture = cam_tex
		connected = true
		lost_frames_timer = 0.0

		# 🖼️ Maintain aspect ratio automatically
		if selected_width > 0 and selected_height > 0:
			_update_camera_view_scale()
			get_tree().root.size_changed.connect(_update_camera_view_scale)
	else:
		_log("❌ Feed activation failed — check permissions or device availability.")
		connected = false

func _process(delta: float) -> void:
	if connected and cam_tex:
		var w: int = cam_tex.get_width()
		var h: int = cam_tex.get_height()

		if w > 32 and h > 32: # ignore transient 0x0 frames
			lost_frames_timer = 0.0
			debug_label.text = "✅ Receiving frames: %dx%d" % [w, h]
		else:
			lost_frames_timer += delta
			debug_label.text = "⏳ Waiting for frames... %.1fs" % [lost_frames_timer]

			if lost_frames_timer > LOST_FRAME_TIMEOUT \
			and (Time.get_ticks_msec() - last_reconnect_time) > (RECONNECT_COOLDOWN * 1000):
				last_reconnect_time = Time.get_ticks_msec()
				_log("⚠️ No frames for %.1fs — attempting to refresh..." % LOST_FRAME_TIMEOUT)
				await _refresh_feed()
				lost_frames_timer = 0.0

func _refresh_feed() -> void:
	if not feed:
		_log("⚠️ No feed to refresh — rescanning feeds.")
		_on_camera_feeds_updated()
		return

	_log("♻️ Refreshing camera feed...")
	feed.set_active(false)
	await get_tree().process_frame
	feed.set_active(true)
	await get_tree().process_frame

	if feed.is_active():
		_log("✅ Feed reactivated successfully.")
	else:
		_log("❌ Feed reactivation failed — will retry later.")
		connected = false

func _update_camera_view_scale() -> void:
	if not camera_view:
		return

	if selected_width <= 0 or selected_height <= 0:
		return

	var viewport_size: Vector2 = get_viewport_rect().size
	var aspect_ratio := float(selected_width) / float(selected_height)
	var target_width := viewport_size.x
	var target_height := target_width / aspect_ratio

	# Fit inside window bounds
	if target_height > viewport_size.y:
		target_height = viewport_size.y
		target_width = target_height * aspect_ratio

	camera_view.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	camera_view.size = Vector2(target_width, target_height)
	camera_view.position = (viewport_size - camera_view.size) / 2.0

	_log("🖥️ Camera view resized to fit %.0fx%.0f (aspect %.2f)" % [target_width, target_height, aspect_ratio])

func _log(msg: String) -> void:
	print(msg)
	debug_label.text += msg + "\n"

```




