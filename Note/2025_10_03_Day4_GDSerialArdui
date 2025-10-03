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



