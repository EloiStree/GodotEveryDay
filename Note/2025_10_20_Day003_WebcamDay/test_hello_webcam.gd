extends CanvasLayer

@export var webcam_view: TextureRect
@export var info_label: Label

func _ready():
	var feed_count: int = CameraServer.get_feed_count()

	if feed_count == 0:
		info_label.text = "No camera feeds found!"
		return

	info_label.text = "Detected %d camera feed(s):\n".format(feed_count)

	# List all available camera feeds and their info
	for i in range(feed_count):
		var feed: CameraFeed = CameraServer.get_feed(i)
		if feed:
			var line := "- [%d] %s (id=%d, active=%s)\n" % [
				i,
				feed.get_name(),
				feed.get_id(),
				str(feed.is_active())
			]
			info_label.text += line
			print(line)

	# Example: use the first available camera feed
	var feed0: CameraFeed = CameraServer.get_feed(0)
	if feed0:
		feed0.set_enabled(true)  # enable capturing if supported
		var tex: Texture2D = feed0.get_texture() as Texture2D
		if tex:
			webcam_view.texture = tex
