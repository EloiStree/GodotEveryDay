Was out of the home. As my Wow champion was ban this morning. I worked in the train with 10 Seconds Ninja.

<img width="1911" height="1124" alt="image" src="https://github.com/user-attachments/assets/75858be8-cd7a-4fbb-a40e-440e9f67b5ca" />
Code: https://github.com/EloiStree/2025_11_11_gdp_wow_int


``` gdscript
class_name GameInputSecondsNinja extends Node

signal on_relay_integer_action(action_as_integer:int)

const ARROW_LEFT = 1037
const ARROW_UP_JUMP = 1038
const ARROW_DOWN = 1040
const ARROW_RIGHT = 1039
const KEY_C_OPTION = 1067
const KEY_R_RETRY = 1082
const KEY_X_SWORD = 1088
const KEY_Z_SHURIKEN = 1090
const BACKSPACE = 1008
const TAB = 1009
const ENTER = 1013
const KEY_ESCAPE = 4194305

func push_int(action_as_integer:int) -> void:
	emit_signal("on_relay_integer_action", action_as_integer)

func press(value:int):
	push_int(value)

func release(value:int):
	push_int(value + 1000)
	
	

func start_moving_left():
	press(ARROW_LEFT)

func stop_moving_left():
	release(ARROW_LEFT )

func start_jumping():
	press(ARROW_UP_JUMP)
func stop_jumping():
	release(ARROW_UP_JUMP)

func start_moving_right():
	press(ARROW_RIGHT)
func stop_moving_right():
	release(ARROW_RIGHT)

func start_arrow_down():
	press(ARROW_DOWN)
func stop_arrow_down():
	release(ARROW_DOWN)

func start_sword_hit():
	press(KEY_X_SWORD)

func stop_sword_hit():
	release(KEY_X_SWORD)

func start_shuriken_hit():
	press(KEY_Z_SHURIKEN)

func stop_shuriken_hit():
	release(KEY_Z_SHURIKEN)

func start_option():
	press(KEY_C_OPTION)
func stop_option():
	release(KEY_C_OPTION)

func start_restart():
	press(KEY_R_RETRY)
	
func stop_restart():
	release(KEY_R_RETRY)

func start_escape():
	press(KEY_ESCAPE)

func stop_escape():
	release(KEY_ESCAPE)

func start_ninja_enum(enum_value:GameInt10SeccondsNina):
	press(GameInt10SeccondsNina.ARROW_LEFT)

func stop_ninja_enum(enum_value:GameInt10SeccondsNina):
	release(enum_value)







enum GameInt10SeccondsNina {
	ARROW_LEFT = 1037,
	ARROW_UP_JUMP = 1038,
	ARROW_DOWN = 1040,
	ARROW_RIGHT = 1039,
	KEY_C_OPTION = 1067,
	KEY_R_RETRY = 1082,
	KEY_X_SWORD = 1088,
	KEY_Z_SHURIKEN = 1090,
	BACKSPACE = 1008,
	TAB = 1009,
	ENTER = 1013,
}

```


``` gdscript
extends Node

@export var ninja: GameInputSecondsNinja

func _ready() -> void:
	while true:
		# Restart action
		await wait(1)
		ninja.start_restart()
		await wait(1)
		ninja.stop_restart()

		# Start moving right
		ninja.start_moving_right()
		await wait(1)
		ninja.stop_moving_right()

		# Start moving left
		ninja.start_moving_left()
		await wait(1)
		ninja.stop_moving_left()

		# Restart action
		await wait(1)
		ninja.start_restart()
		await wait(1)
		ninja.stop_restart()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

```
