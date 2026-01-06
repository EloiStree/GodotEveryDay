Did some administrative stuff...  
  
And a video on the objective of 2026  
https://youtu.be/m-yj6nC_sfk?t=132  
Make a guide to learn code by playing game.  

So to not break the strike, I am going to make the IntPlay To of Steath bastard:
- https://github.com/EloiStree/2026_01_02_gdp_playto
- https://github.com/EloiStree/PlayTo_StealthBastard


<img width="715" height="114" alt="image" src="https://github.com/user-attachments/assets/22070e43-7f2b-4e29-8b6d-0331d7e88917" />


``` gdscript


class_name IntInputForStealthBastard extends IntInputFor

@export_group("Stealth Bastard Controls")
@export var move_left = S2W_Enum_Keyboard.EnumIntegerKeyboard.Left
@export var move_right = S2W_Enum_Keyboard.EnumIntegerKeyboard.Right
@export var move_up = S2W_Enum_Keyboard.EnumIntegerKeyboard.Up
@export var move_down = S2W_Enum_Keyboard.EnumIntegerKeyboard.Down
@export var jump = S2W_Enum_Keyboard.EnumIntegerKeyboard.Z
@export var game_continue = S2W_Enum_Keyboard.EnumIntegerKeyboard.Z
@export var carry_throw = S2W_Enum_Keyboard.EnumIntegerKeyboard.X
@export var gadget = S2W_Enum_Keyboard.EnumIntegerKeyboard.C
@export var restart_level = S2W_Enum_Keyboard.EnumIntegerKeyboard.R

@export_group("Usable keys in game")
@export var key_x = S2W_Enum_Keyboard.EnumIntegerKeyboard.X
@export var key_z = S2W_Enum_Keyboard.EnumIntegerKeyboard.Z
@export var key_c = S2W_Enum_Keyboard.EnumIntegerKeyboard.C
@export var key_r = S2W_Enum_Keyboard.EnumIntegerKeyboard.R
@export var key_arrow_left = S2W_Enum_Keyboard.EnumIntegerKeyboard.Left
@export var key_arrow_right = S2W_Enum_Keyboard.EnumIntegerKeyboard.Right
@export var key_arrow_up = S2W_Enum_Keyboard.EnumIntegerKeyboard.Up
@export var key_arrow_down = S2W_Enum_Keyboard.EnumIntegerKeyboard.Down

func release_all_keys():
	release_key(key_arrow_left)
	release_key(key_arrow_right)
	release_key(key_arrow_up)
	release_key(key_arrow_down)
	release_key(key_x)
	release_key(key_z)
	release_key(key_c)
	release_key(key_r)
	release_key(key_escape)
	release_key(key_enter)

func start_moving_left():
	press_key(move_left)
func stop_moving_left():
	release_key(move_left)
func start_moving_left_for_seconds(seconds: float):
	press_key_in_seconds(move_left, seconds)

func start_moving_right():
	press_key(move_right)
func stop_moving_right():
	release_key(move_right)
func start_moving_right_for_seconds(seconds: float):
	press_key_in_seconds(move_right, seconds)

func start_moving_up():
	press_key(move_up)
func stop_moving_up():
	release_key(move_up)
func start_moving_up_for_seconds(seconds: float):
	press_key_in_seconds(move_up, seconds)

func start_moving_down():
	press_key(move_down)
func stop_moving_down():
	release_key(move_down)
func start_moving_down_for_seconds(seconds: float):
	press_key_in_seconds(move_down, seconds)

func start_carrying_or_throwing():
	press_key(carry_throw)
func stop_carrying_or_throwing():
	release_key(carry_throw)
func carry_or_throw_for_seconds(seconds: float):
	press_key_in_seconds(carry_throw, seconds)

func use_gadget():
	stroke_key_200_milliseconds(gadget)

func start_use_gadget():
	press_key(gadget)
	
func stop_use_gadget():
	release_key(gadget)

func use_gadget_for_seconds(seconds: float):
	press_key_in_seconds(gadget, seconds)
	
func stroke_restart_level():
	stroke_key_1_seconds(restart_level)

func press_restart_level():
	press_key(restart_level)

func release_restart_level():
	release_key(restart_level)

func start_jumping():
	press_key(jump)

func stop_jumping():
	release_key(jump)

func start_continue():
	press_key(game_continue)

func stop_continue():
	release_key(game_continue)


func stroke_game_continue_for_seconds(seconds: float):
	press_key_in_seconds(game_continue, 0)
	press_key_in_seconds(game_continue + 1000, seconds)

func stroke_jump_for_seconds(seconds: float):
	press_key_in_seconds(jump, 0)
	press_key_in_seconds(jump + 1000, seconds)



```
