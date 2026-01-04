


This one is easy to teach but is note easy to manage on the timing.
Better if you directly give the when to execute or do a macro like I like to do in OMI.

It would be nice to work on the date NTP to be able to create millisecond acquracy as we are on hardware.


Note: While I was thinking about the NTP part of the Pico 2W, I realized that for teaching kids it’s not a good idea. There’s too much to take into account.
What I can do instead is: if the UDP packet is over 16 bytes, it means that it is an array of 16 bytes. Then I can check whether the date is under 30 seconds in milliseconds (1000 * 3600 * 30). If it is, then it means that it is a macro type.
What this changes is that we can send a block of integers in one packet and be guaranteed millisecond-level execution on the hardware side and 1–10 milliseconds on the software side of the receiver.


``` gdscript

extends Node

@export var input: IntInputFor10SecondsNinja
@export var auto_start := true

var _level1_running := false


func _ready() -> void:
	if auto_start:
		start_coroutine_loop_level_1()


func wait_for_seconds(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func wait_for_milliseconds(milliseconds: int) -> void:
	await get_tree().create_timer(milliseconds / 1000.0).timeout


func is_coroutine_loop_level_1_running() -> bool:
	return _level1_running


func set_coroutine_loop_level_1_running(running: bool) -> void:
	if running:
		start_coroutine_loop_level_1()
	else:
		stop_coroutine_loop_level_1()


func toggle_coroutine_loop_level_1() -> void:
	if is_coroutine_loop_level_1_running():
		stop_coroutine_loop_level_1()
	else:
		start_coroutine_loop_level_1()


func stop_coroutine_loop_level_1() -> void:
	_level1_running = false

func start_coroutine_loop_level_1() -> void:
	if _level1_running:
		return

	_level1_running = true

	while _level1_running:
		input.release_all_keys()
		await wait_for_seconds(1.0)

		input.press_key(input.restart)
		await wait_for_seconds(1.0)

		input.release_key(input.restart)
		await wait_for_seconds(1.0)

		input.start_move_right()
		await wait_for_seconds(0.3)

		input.stop_move_right()
		await wait_for_seconds(0.18)

		input.attack_with_shuriken()
		await wait_for_seconds(0.1)

		input.start_jumping()
		await wait_for_seconds(0.3)

		input.stop_jumping()
		await wait_for_seconds(0.1)

		input.start_move_left()
		await wait_for_seconds(0.1)

		input.start_jumping()
		await wait_for_seconds(0.3)

		input.stop_jumping()
		await wait_for_seconds(0.05)

		input.stop_move_left()
		await wait_for_seconds(0.05)

		input.start_move_right()
		await wait_for_seconds(0.05)

		input.press_key(input.sword)
		await wait_for_seconds(00.05)
		input.release_key(input.sword)
		await wait_for_seconds(00.05)
		input.start_jumping()
		await wait_for_seconds(0.3)

		input.stop_jumping()
		await wait_for_seconds(0.05)


		input.start_jumping()
		await wait_for_seconds(0.3)

		input.stop_jumping()
		await wait_for_seconds(0.05)

		input.attack_with_shuriken()
		await wait_for_seconds(0.1)


		input.stop_move_right()

		await wait_for_seconds(2.0)
```


