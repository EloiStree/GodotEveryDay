


```gdscript

class_name IntInputForArcRaider extends Node


signal on_integer_action_requested(integer_value:int)
signal on_integer_delay_action_requested_in_milliseconds(integer_value:int, milliseconds_delay:int)

@export var move_left = S2W_Enum_Keyboard.EnumIntegerKeyboard.A
@export var move_right = S2W_Enum_Keyboard.EnumIntegerKeyboard.D
@export var move_forward = S2W_Enum_Keyboard.EnumIntegerKeyboard.W
@export var move_backward = S2W_Enum_Keyboard.EnumIntegerKeyboard.S
@export var toggle_crouch = S2W_Enum_Keyboard.EnumIntegerKeyboard.ClearTimedCommand
@export var crouch = S2W_Enum_Keyboard.EnumIntegerKeyboard.LeftControl

@export var jump = S2W_Enum_Keyboard.EnumIntegerKeyboard.Space

@export var use_flash_light = S2W_Enum_Keyboard.EnumIntegerKeyboard.F

@export var open_inventory = S2W_Enum_Keyboard.EnumIntegerKeyboard.Tab
@export var open_map = S2W_Enum_Keyboard.EnumIntegerKeyboard.M
@export var interact = S2W_Enum_Keyboard.EnumIntegerKeyboard.E
@export var weapon_1 = S2W_Enum_Keyboard.EnumIntegerKeyboard.Alpha1
@export var weapon_2 = S2W_Enum_Keyboard.EnumIntegerKeyboard.Alpha2
@export var weapon_melee = S2W_Enum_Keyboard.EnumIntegerKeyboard.Alpha3
@export var ability= S2W_Enum_Keyboard.EnumIntegerKeyboard.Alpha3
@export var talk_to_ally = S2W_Enum_Keyboard.EnumIntegerKeyboard.Z
@export var talk_to_all = S2W_Enum_Keyboard.EnumIntegerKeyboard.B


func push_action(value:int):
	on_integer_action_requested.emit(value)

func push_action_delay_seconds(value:int,seconds:float):
	on_integer_delay_action_requested_in_milliseconds.emit(value,seconds*1000)
	
func push_action_delay_milliseconds(value:int,milliseconds:int):
	on_integer_delay_action_requested_in_milliseconds.emit(value,milliseconds)

func stroke_key_seconds(value:int, delay_seconds:float):
	push_action(value)
	push_action_delay_seconds(value+1000,delay_seconds)
	
func stroke_key_milliseconds(value:int, delay_ms:int):
	push_action(value)
	push_action_delay_milliseconds(value+1000,delay_ms)
	
	
func stroke_key_200ms(value:int):
	stroke_key_milliseconds(value,200)
	
func stroke_open_map()->void:
	stroke_key_200ms(open_map)
	
func stroke_inventory()->void:
	stroke_key_200ms(open_inventory)

func stroke_flashlight()->void:
	stroke_key_milliseconds(open_inventory,50)
	
func press_key(value:int):
	push_action(value)	
	
func release_key(value:int):
	push_action(value)	
	
func start_moving_left():
	press_key(move_left)	
	
func stop_moving_left():
	release_key(move_left)	

func start_moving_right():
	press_key(move_right)	
	
func stop_moving_right():
	release_key(move_right)	
	
	
func start_moving_forward():
	press_key(move_forward)	
	
func stop_moving_forward():
	release_key(move_forward)	

func start_moving_backward():
	press_key(move_backward)	
	
func stop_moving_backwarod():
	release_key(move_backward)	
	

func start_crouch():
	press_key(crouch)	
	
func stop_crouch():
	release_key(crouch)	

func stroke_toggle_crouch():
	stroke_key_200ms(toggle_crouch)	
	

	


```
