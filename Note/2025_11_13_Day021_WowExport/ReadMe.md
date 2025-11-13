I am wondering how hard it is to use the asset of wow export in Godot to teach how to make video fan base of World of Warcraft.  
Without the question of the legallity, just is it possible and how hard it is ?    
  
The idea would be to create mini fan game with kids.  
Like a fan video made in the past.  


Also I tried on Linux and the camera dont appear.
So I will try a list time on mac this code
``` gdscript
extends Node

@export var viewport: SubViewport
@export var texture_rect: TextureRect

var feed: CameraFeed
var camera_texture: CameraTexture

func _ready() -> void:
	print("Initializing camera system...")

	# Connect to signal to detect new or removed camera feeds
	CameraServer.camera_feeds_updated.connect(_on_camera_feeds_updated)

	# Enable monitoring (required for automatic feed updates)
	CameraServer.monitoring_feeds = true

	# Initial detection of current feeds
	_on_camera_feeds_updated()


func _on_camera_feeds_updated() -> void:
	print("Camera feeds updated.")
	var feeds = CameraServer.feeds()

	if feeds.is_empty():
		push_warning("No camera feeds detected.")
		print("No camera feeds found.")
		return

	print("Available camera feeds:")
	for i in range(feeds.size()):
		print("  [%d] %s" % [i, feeds[i].get_name()])

	# Use the first available feed
	feed = feeds[0]
	print("Using feed: %s" % feed.get_name())

	# Create a CameraTexture for this feed
	camera_texture = CameraTexture.new()
	camera_texture.camera_feed_id = feed.get_id()

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
