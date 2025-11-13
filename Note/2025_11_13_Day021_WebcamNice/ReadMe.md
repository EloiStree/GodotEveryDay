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






