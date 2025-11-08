I tried a third time to use Camera Extension but I am too bad at it apparently failed.

On Apple and and Linux maybe the Godot Editor can access the code.
I have to try.

But on  Window without the GDExtension it is hell.
No tutorial.

I am going to install ubuntu on a computer and try on the apple of the familly to check.



Last attempt
``` gdscript
extends Node

@export var viewport: SubViewport
@export var texture_rect: TextureRect

var feed: CameraFeed
var camera_texture: CameraTexture

func _ready() -> void:
	print("Hello A")
	# Get all available camera feeds
	var feeds = CameraServer.feeds()
	print("Hello B")

	if feeds.is_empty():
		print("No camera feeds")
		push_warning("No camera feeds detected.")
		return
	print("Hello C")

	# Print all available feeds
	print("Available camera feeds:")
	for i in feeds.size():
		print("  [%d] %s" % [i, feeds[i].get_name()])

	# Use the first available feed
	feed = feeds[0]
	print("Using feed: %s" % feed.get_name())

	# Create and configure the CameraTexture
	camera_texture = CameraTexture.new()
	camera_texture.camera_feed_id = feed.get_id()
	# (In Godot 4.5, which_feed no longer needed)

	# Assign it to the TextureRect
	if texture_rect:
		texture_rect.texture = camera_texture
	else:
		push_warning("TextureRect not assigned in the Inspector.")

	# Match viewport size (optional)
	if viewport and texture_rect:
		texture_rect.size = viewport.size

	# Activate the camera
	feed.active = true
	print("Camera feed started successfully.")


```
