
Ok lets explore a bit how touch screen work on the Pi with Godot.



``` gdscript
# Godot Engine v4.5.1.stable.official.f62fdbde1 - https://godotengine.org
# OpenGL API OpenGL ES 3.1 Mesa 24.2.8-1~bpo12+rpt3 - Compatibility - Using Device: Broadcom - V3D 7.1.10.2

# === Joypad 0 ===
# Name: Raspberry Pi Pico W
# Info: { "raw_name": "Raspberry Pi Pico W", "vendor_id": "9114", "product_id": "33056", "xinput_index": "0" }
# GUID: 030028959a2300002081000011010000
# Known mapping: false


func _ready() -> void:
	var joypads := Input.get_connected_joypads()
	var output := []
	
	for device_id in joypads:
		output.append("=== Joypad %d ===" % device_id)
		output.append("Name: %s" % Input.get_joy_name(device_id))
		output.append("Info: %s" % Input.get_joy_info(device_id))
		output.append("GUID: %s" % Input.get_joy_guid(device_id))
		output.append("Known mapping: %s" % str(Input.is_joy_known(device_id)))
		output.append("") # Empty line for spacing

	for_debug_joy_pads = "\n".join(output)
	print(for_debug_joy_pads) # Optional: also print to console


````


```

Input.is_physical_key_pressed(KEY_SPACE)
Input.set_custom_mouse_cursor(texture)

# connect disconnect
Input.joy_connection_changed
```
 
**The screen I am using with my PI is considered as a mouse and not a screen touch.**   
So I cant really make test outside of mobile but I am not ready for that.  
Maybe in the Quest.   

