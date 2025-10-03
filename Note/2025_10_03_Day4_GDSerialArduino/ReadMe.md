a script that try to connect to an ESP32-S3 with port to send and received Info.

``` gdscript
extends Node

var serial: GdSerial

func _ready():
	# Create serial instance
	serial = GdSerial.new()
	
	# List available ports
	print("Available ports:")
	var ports = serial.list_ports()
	for i in range(ports.size()):
		var port_info = ports[i]
		print("Port info ", i, ":")
		for key in port_info.keys():
			print("  ", key, ": ", port_info[key])

	# Configure and open port
	serial.set_port("COM13")  # Adjust for your system
	serial.set_baud_rate(9600)
	serial.set_timeout(3000)
	
	if serial.open():
		await get_tree().create_timer(0.1).timeout
		print("Port opened successfully!")
		await get_tree().create_timer(0.1).timeout
		
		# Send command
		serial.writeline("Hello Arduino!")
		
		# Wait and read response
		await get_tree().create_timer(0.1).timeout
		while serial.bytes_available() > 0:
			var response = serial.readline()
			print("Response: ", response)
		serial.close()
	else:
		print("Failed to open port")
```



answer
``` 

Godot Engine v4.4.1.stable.official.49a5bc7b6 - https://godotengine.org
OpenGL API 3.3.0 Core Profile Context 24.12.1.241127 - Compatibility - Using Device: ATI Technologies Inc. - AMD Radeon(TM) Graphics

Available ports:
Port info 0:
  port_name: COM10
  port_type: Unknown
  device_name: Unknown Serial Device
Port info 1:
  port_name: COM9
  port_type: Unknown
  device_name: Unknown Serial Device
Port info 2:
  port_name: COM13
  port_type: USB - VID: 1A86, PID: 55D3
  device_name: wch.cn USB-Enhanced-SERIAL CH343 (COM13)
Port info 3:
  port_name: COM14
  port_type: Unknown
  device_name: Unknown Serial Device
Port info 4:
  port_name: COM15
  port_type: Unknown
  device_name: Unknown Serial Device
Port opened successfully!
Response: Received: H
Response: Received: e
Response: Received: l
Response: Received: l
Response: Received: o
Response: Received:  
Response: Received: A
Response: Received: r
Response: Received: d
Response: Received: u
Response: Received: i
Response: Received: n
Response: Received: o
Response: Received: !
Response: Received: 
Response: 
--- Debugging process stopped ---
```
