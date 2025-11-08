Ok I started a singleton but now I have a new code that allows to push the bullets event and one that listen to the event

When it is done 
- I am going to attack the parsing of artillery and linear bullets.
- I will have to make bytes parser for both of them to be able to host game
- link a the linar and the ballistic bullet to a wow movement
- broadcast information
- reword the idd non secure rsa version




``` gdscript

# BallisticBulletSingletonEventListener.gd
class_name BallisticBulletSingletonEventListener
extends Node


signal on_bullet_fired(fired_start_point: BallisticStructs.STRUCT_BallisticStartPoint)
signal on_bullet_destroyed(
	fired_start_point: BallisticStructs.STRUCT_BallisticStartPoint,
	destroyed_end_point: BallisticStructs.STRUCT_BallisticsEndPoint
)


@export var debug_last_received_fired_start :BallisticStructs.STRUCT_BallisticStartPoint
@export var debug_last_received_destroyed_start :BallisticStructs.STRUCT_BallisticStartPoint
@export var debug_last_received_destoyed_end :BallisticStructs.STRUCT_BallisticsEndPoint
# Signals


func _ready() -> void:
	connect_to_events()

func _exit_tree() -> void:
	disconnect_from_events()

func connect_to_events() -> void:
	BallisticBulletSingletonEvent.add_listener_start_bullet(_on_bullet_fired_internal)
	BallisticBulletSingletonEvent.add_listener_end_bullet(_on_bullet_destroyed_internal)

func disconnect_from_events() -> void:
	if not BallisticBulletSingletonEvent:
		return

	BallisticBulletSingletonEvent.remove_listener_start_bullet(_on_bullet_fired_internal)
	BallisticBulletSingletonEvent.remove_listener_end_bullet(_on_bullet_destroyed_internal)

# Internal wrappers to allow overriding
func _on_bullet_fired_internal(start_point: BallisticStructs.STRUCT_BallisticStartPoint) -> void:
	BallisticStructs.copy_start_point(start_point, debug_last_received_fired_start)
	on_bullet_fired.emit(start_point)

func _on_bullet_destroyed_internal(
	start_point: BallisticStructs.STRUCT_BallisticStartPoint,
	end_point: BallisticStructs.STRUCT_BallisticsEndPoint
) -> void:
	BallisticStructs.copy_start_point(start_point, debug_last_received_destroyed_start)
	BallisticStructs.copy_end_point(end_point, debug_last_received_destoyed_end)
	on_bullet_destroyed.emit(start_point, end_point)
	
func print_bullet_fired_internal(start_point: BallisticStructs.STRUCT_BallisticStartPoint) -> void:
	var str_build = "Bullet Fired: " + str(start_point)
	print(str_build)		

func print_bullet_destroyed_internal(
	start_point: BallisticStructs.STRUCT_BallisticStartPoint,
	end_point: BallisticStructs.STRUCT_BallisticsEndPoint
) -> void:
	var str_build = "Bullet Destroyed - Start: " + str(start_point) + ", End: " + str(end_point)
	print(str_build)		

```


``` gdscript

# BallisticBulletSingletonEventPusher.gd
class_name BallisticBulletSingletonEventPusher
extends Node

@export var debug_last_pushed_fired_start :BallisticStructs.STRUCT_BallisticStartPoint
@export var debug_last_pushed_destroyed_start :BallisticStructs.STRUCT_BallisticStartPoint
@export var debug_last_pushed_destroyed_end :BallisticStructs.STRUCT_BallisticsEndPoint

## Push a bullet fired event
func notify_fired_bullet(start_point: BallisticStructs.STRUCT_BallisticStartPoint) -> void:
	BallisticStructs.copy_start_point(start_point, debug_last_pushed_fired_start)
	BallisticBulletSingletonEvent.from_global_trigger_bullet_fired(start_point)
	
## Push a bullet destroyed event
func notify_destroyed_bullet(
	start_point: BallisticStructs.STRUCT_BallisticStartPoint,
	end_point: BallisticStructs.STRUCT_BallisticsEndPoint
) -> void:
	BallisticStructs.copy_start_point(start_point, debug_last_pushed_destroyed_start)
	BallisticStructs.copy_end_point(end_point, debug_last_pushed_destroyed_end)
	BallisticBulletSingletonEvent.from_global_trigger_bullet_destroyed(start_point, end_point)


```



By aim when I was going to the Cassini hackathon was to make a simple Artillery DOS game.
But as soon as you use float32 in game engine you are limited to 8.4km and less.

So i need to turn my tool to cm presision integer32 to make it works.
Version one will be on flat earth map to be compatible with World of Warcraft map



``` gdscript

class STRUCT_IntCmPrecision:
	# I need an artillery dos game playble on a planet earth scale
	# So I need to store position in cm precision with int32
	# Max integer value for cm precision is 21,474,836.47 meter (21,474 km)
	var value_i32cm: int = 0

	
	const MAX_VALUE_I32CM = 2147483647  # Max positive value for int32
	const MIN_VALUE_I32CM = -2147483648 # Min negative value for int32
	const MAX_VALUE_IN_KM = 21474.83647  # Convert cm to km
	const MIN_VALUE_IN_KM = -21474.83648  # Convert cm to km
	const MAX_VALUE_IN_METER = 21474836.47  # Convert cm to meter
	const MIN_VALUE_IN_METER = -21474836.48  # Convert cm to meter

class STRUCT_IntMaxDegreePrecision360:
	## I want to make artillery game on a planet scale so 42000 km circumference max.
	## it means that I need precise degree instead of the classic 180.00
	## Max integer value for degree with 0.000001 precision and 360 degrees is 360,000,000 
	var value_i32_360_000000: int = 0

```




