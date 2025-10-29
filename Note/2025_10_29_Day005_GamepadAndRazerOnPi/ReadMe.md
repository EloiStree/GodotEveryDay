I create from an old code a gamepad with Pico W.  
Lets see how to read it in Godot.  

Also I found a Razer need driver on Window.  
Can I read it in Pi as a random classic input ?  


Supprisingly Yes. you can read Razer Nostromo in the Godot Engine on PI
and you can read the name of the Gamepad.

Meaning that you can build fake pico gamepad with name for ID in game.



```
extends Node


func _ready():
	var joypads = Input.get_connected_joypads()
	for device_id in joypads:
		print("ID:", device_id)
		print("Name:", Input.get_joy_name(device_id))
		print("GUID:", Input.get_joy_guid(device_id))
		print("Known mapping:", Input.is_joy_known(device_id))

func _input(event):
	print("\n=== New Input Event ===")
	print("Event class:", event.get_class())
	print("Device ID:", event.device)

	# --- KEYBOARD ---
	if event is InputEventKey:
		print("=== Keyboard Event ===")
		print("Scancode:", event.physical_keycode)
		print("Keycode:", event.keycode)
		print("Unicode:", event.unicode)
		print("Pressed:", event.pressed)
		print("Echo:", event.echo)
		print("Alt:", event.alt_pressed)
		print("Ctrl:", event.ctrl_pressed)
		print("Shift:", event.shift_pressed)
		print("Meta:", event.meta_pressed)

	# --- JOYPAD BUTTON ---
	elif event is InputEventJoypadButton:
		print("=== Joypad Button Event ===")
		print("Button index:", event.button_index)
		print("Pressed:", event.pressed)
		print("Pressure:", event.pressure)
		print("Is pressed():", event.is_pressed())
		print("Device name:", Input.get_joy_name(event.device))

	# --- JOYPAD MOTION (sticks/triggers) ---
	elif event is InputEventJoypadMotion:
		print("=== Joypad Motion Event ===")
		print("Device name:", Input.get_joy_name(event.device))
		print("Axis:", event.axis)
		print("Axis value:", event.axis_value)

	# --- MOUSE BUTTON ---
	elif event is InputEventMouseButton:
		print("=== Mouse Button Event ===")
		print("Button index:", event.button_index)
		print("Pressed:", event.pressed)
		print("Position:", event.position)
		print("Global position:", event.global_position)
		print("Factor:", event.factor)
		print("Double click:", event.double_click)
#
		##print("Tilt:", event.tilt)
		#print("Pressure:", event.pressure)

	# --- MOUSE MOTION ---
	elif event is InputEventMouseMotion:
		print("=== Mouse Motion Event ===")
		print("Position:", event.position)
		print("Relative:", event.relative)
		print("Velocity:", event.velocity)
		print("Pressure:", event.pressure)
		print("Tilt:", event.tilt)

	# --- TOUCHSCREEN TAP ---
	elif event is InputEventScreenTouch:
		print("=== Screen Touch Event ===")
		print("Index:", event.index)
		print("Pressed:", event.pressed)
		print("Position:", event.position)

	# --- TOUCHSCREEN DRAG ---
	elif event is InputEventScreenDrag:
		print("=== Screen Drag Event ===")
		print("Index:", event.index)
		print("Position:", event.position)
		print("Relative:", event.relative)
		print("Speed:", event.speed)

	# --- ACTION EVENTS (mapped actions like "ui_accept") ---
	elif event is InputEventAction:
		print("=== Input Action Event ===")
		print("Action name:", event.action)
		print("Pressed:", event.pressed)
		print("Strength:", event.strength)
		print("Is pressed():", event.is_pressed())

	# --- MAGNIFY GESTURE (touchpad pinch) ---
	elif event is InputEventMagnifyGesture:
		print("=== Magnify Gesture Event ===")
		print("Factor:", event.factor)
		print("Position:", event.position)

	# --- PAN GESTURE (touchpad two-finger drag) ---
	elif event is InputEventPanGesture:
		print("=== Pan Gesture Event ===")
		print("Delta:", event.delta)
		print("Position:", event.position)

	# --- UNKNOWN / OTHER ---
	else:
		print("Unhandled event type:", event)

func _process(delta):
	pass
	# You can add any per-frame logic here if needed
	



```
