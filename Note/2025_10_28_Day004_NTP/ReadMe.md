I worked on the convention to received on the Pico 2W
https://github.com/EloiStree/HelloLanCodeTournamentAbstraction/blob/main/README.md

And on the Pico W code.

I should work on the push position but maybe a bit of look around on NTP is better.


<img width="854" height="232" alt="image" src="https://github.com/user-attachments/assets/b2db53ae-cc33-40fe-8af9-c0e74ece64f3" />

``` gdscript
# NetworkTimeHTTP.gd
extends Node

const TIME_API = "https://worldtimeapi.org/api/timezone/Etc/UTC"

@export var ntp_difference_in_ms: float = 0.0  # Difference between NTP and local time (ms)

func _ready() -> void:
	ntp_difference_in_ms = await get_utc_time()
	print("HTTP NTP ",ntp_difference_in_ms)

func get_utc_time() -> float:
	var http := HTTPRequest.new()
	add_child(http)
	var err = http.request(TIME_API)
	if err != OK:
		push_warning("Failed to request time API")
		return -1

	var result = await http.request_completed
	var response_code = result[1]
	var body = result[3]
	if response_code != 200:
		push_warning("HTTP error: %d" % response_code)
		return -1

	var data = JSON.parse_string(body.get_string_from_utf8())
	if typeof(data) == TYPE_DICTIONARY and "unixtime" in data:
		return float(data["unixtime"])
	return -1



```
