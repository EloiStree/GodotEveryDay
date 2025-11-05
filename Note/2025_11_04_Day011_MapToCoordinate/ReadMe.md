I am going in a hackathon where I want to explore the API of the sponsor in Godot.
To do so I want to make before and after the hackathon a small artillery dos game.

3D Map take too much space and require server or API. 

So I suppose I will have to download elevator API and install it on local PC for tournament.
And generate gride of point around the hit target.

For now, what I can explore is the same feature as Fusion 360.

Take some 2D map image, give them two gps point with the distance between them to compute rough estimation of in game shoot.
Also, it would allows to generate 2D color image of a battle zone from the sponsor API then use compute shader and Texture2D to work on it.


https://github.com/EloiStree/2025_11_04_gdp_point_to_point_map

-----

They are some cool set get export property in godot


``` gdscript
@tool
extends Node
class_name GpsThreePointsOnMapNode

@export_group("Reference")
@export var point_a: GpsPointNode3D
@export var point_b: GpsPointNode3D
@export var point_c: GpsPointNode3D

@export var given_real_world_distance_a_b: float = 0.0 :
	set(value):
		if given_real_world_distance_a_b != value:
			given_real_world_distance_a_b = value
			update_distance_compute_data()
	get:
		return given_real_world_distance_a_b

# @export_tool_button("Update Distance Compute Data","Callable")
# var some_func_right_after: Callable = func(): update_distance_compute_data()

@export_group("Computed data")
@export var game_world_distance_a_b: float



@export var deduced_real_world_distance_b_c: float
@export var game_world_distance_b_c: float

@export var deduced_real_world_distance_c_a: float
@export var game_world_distance_c_a: float

@export var total_distance_in_game: float
@export var total_distance_in_real_life: float

@export var point_a_engine_position: Vector3
@export var point_b_engine_position: Vector3
@export var point_c_engine_position: Vector3


func _ready() -> void:
	update_distance_compute_data()
	
func update_distance_compute_data() -> void:
	game_world_distance_a_b = point_a.global_transform.origin.distance_to(point_b.global_transform.origin)
	game_world_distance_b_c = point_b.global_transform.origin.distance_to(point_c.global_transform.origin)
	game_world_distance_c_a = point_c.global_transform.origin.distance_to(point_a.global_transform.origin)
	deduced_real_world_distance_b_c = (given_real_world_distance_a_b / game_world_distance_a_b) * game_world_distance_b_c
	deduced_real_world_distance_c_a = (given_real_world_distance_a_b / game_world_distance_a_b) * game_world_distance_c_a
	total_distance_in_real_life = given_real_world_distance_a_b + deduced_real_world_distance_b_c + deduced_real_world_distance_c_a
	total_distance_in_game = game_world_distance_a_b + game_world_distance_b_c + game_world_distance_c_a
	point_a_engine_position = point_a.global_transform.origin
	point_b_engine_position = point_b.global_transform.origin
	point_c_engine_position = point_c.global_transform.origin


```
