I tried Wow... So I have minutes left.
<img width="530" height="706" alt="image" src="https://github.com/user-attachments/assets/c5c67165-fd88-49b1-9ff9-e9e87c2391c4" />



Lets look at curve
https://github.com/EloiStree/HelloGodotCode/issues/53
<img width="1393" height="637" alt="image" src="https://github.com/user-attachments/assets/a74c2a6d-9015-4c24-9403-5cc237e5a60e" />


``` gdscript

extends Node


@export var height_curve_with_time :Curve 
@export var height_max := 1
@export var max_time = 6.0
@export var current_height := 0.0
@export var node_to_move_vertically: Node3D
	
func _process(delta: float) -> void:
	var time: float = float(Time.get_ticks_msec()) / 1000.0
	
	time = time - floor(time / max_time) * max_time
	var percent = time / max_time
	var value_at_percent = height_curve_with_time.sample(percent)
	current_height = value_at_percent * height_max

	node_to_move_vertically.position.y = current_height


```
