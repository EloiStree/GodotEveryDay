No time to learn so lets pratice the export params.

- https://github.com/EloiStree/HelloGodotCode/issues/58
- https://github.com/EloiStree/HelloGodotCode/issues/57
- https://github.com/EloiStree/HelloGodotCode/issues/56


something cool to export:
https://docs.godotengine.org/en/latest/classes/class_object.html#class-object-private-method-get-property-list


What I played around. I should learn next how to comment correctly my code and interface
``` gdscript

@tool
extends Node3D

class_name LetExploreExport3D
"""
So what is export ?
Manual: https://docs.godotengine.org/en/latest/tutorials/scripting/gdscript/gdscript_exports.html#
"""

@export var this_is_an_export: String = "Hello"

@export var it_works_with_node : Node3D = self
# self did not work.. Maybe https://www.reddit.com/r/godot/comments/75a9fe/get_actual_node_instead_of_script_on_node

"""
You can make group and subgroup of variable
"""
@export_group("Compute / Addition")
@export var you_can_do_groupe : float = 3

"""
You can use set and get to project in the editor to affect other value.
Could work in local but work in remote scene at play mode.
"""

@export var compute_add_A : float = 2:
	set(value):
		compute_add_A = value
		make_addition()
		print("New value for A is ", compute_add_A)

@export var compute_add_B : float = 1:
	set(value):
		compute_add_B = value
		make_addition()
		print("New value for B is ", compute_add_B)

func make_addition():
	self.you_can_do_groupe = compute_add_A + compute_add_B

@export_subgroup("Extra Properties")
@export var string = ""
@export var flag = false

"""
apparently you can t stack subgroup like this
"""
@export_subgroup("Extra ")
@export var stringg = ""
@export var flagg = false


"""
What does catergory do ?
It create a whole new square to split two part of the inspector
"""

@export_category("Main Category")
@export var numberh = 3
@export var stringh = ""



"""
Lets explore the file path
"""


@export_category("File Path")
@export_file var file_path : String
@export_dir var dir_path : String
@export_global_file var global_dir_path : String
@export_global_dir var global_file_path : String
@export_file("*.md") var markdown_file : String

"""
Most importantly the multiline export
"""
@export_multiline var long_text : String = "You can write a lot of text here.
Like really a lot of text.
It will be displayed in a big box in the inspector.
This is useful for writing long descriptions or notes."


"""
Export range to limite the designer input
"""
@export_range(0, 100, 5) var ranged_value : int = 50

"""
Does it works with text

"""

# apparently no
# @export_range(1,10) var ranged_float : String 


"""
What ?
Ok, apparently you can use less or more of this value
"""
@export_range(0, 100, 1, "or_less") var less_than_100: int
@export_range(0, 100, 1, "suffix:m") var meter: int
#radian 
""" 
This one apparentl display degrees to the game designer but is in radian
Not sure I like it, that could make explode a space ship if you forget
"""
@export_range(0, 360, 0.1, "radians_as_degrees") var angle: float
#degree
@export_range(0, 360, 1, "radians_as_degrees") var radian: float

@export_range(0, 100, 1, "hide_slider") var slider_value: int


"""
No idea yet of what is easing
"""

@export_exp_easing var transition_speed



@export var color: Color = Color(1, 0, 0, 1)
@export_color_no_alpha  var color_no_alpha: Color = Color(0, 1, 0)


"""

This is a bit particuliar one.
It give the abilityt to select a node from the scene tree
But only of the given types
"""

@export_node_path("MeshInstance3D", "TouchScreenButton") var some_button_path 


"""
This one let you drop resource from file in project in the inspector
"""
@export var resource: Resource
@export var texture: Texture2D
@export var packed_scene: PackedScene
@export var material: StandardMaterial3D
@export var shader: Shader


"""
Lets create a layer on the go
One and zero that compose a bitmask
"""

# Set any of the given flags from the editor.
@export_flags("Fire", "Water", "Earth", "Wind") var spell_elements_bitmasks = 0:
	set(value):
		spell_elements_bitmasks = value
		print("New spell elements bitmask: ", spell_elements_bitmasks)
		print("Binary: ", String.num_int64(spell_elements_bitmasks, 2).pad_zeros(4))


"""
Play with bits group directly on a bitmaks
"""
@export_flags("Self:4", "Allies:8", "Foes:16") var spell_targets_bitmasks = 0



'''Of course enum'''

enum NamedEnum {THING_1, THING_2, ANOTHER_THING = -1}
@export var x: NamedEnum

""" but you can use fake enum"""
@export_enum("Slow:30", "Average:60", "Very Fast:200") var character_speed: int

"""Or string menu type of enum"""

@export_enum("Rebecca", "Mary", "Leah") var character_name: String = "Rebecca"


"""I knew you can export array but did not know about double one export"""
@export var two_dimensional: Array[Array] = [[1.0, 2.0], [3.0, 4.0]]

"""Let check the array but different"""
@export var vector3s = PackedVector3Array()
@export var strings = PackedStringArray()


"""The inverse of System.Serialize
Will be in the class to be exported but not visible in the editor
"""
@export_storage var what_to_save


"""Custom one"""
@export_custom(PROPERTY_HINT_NONE, "suffix:md") var altitude: float


@export_tool_button("Push me", "Callable") var hello_action = hello

func hello():
	print("Satisfaction")


```

Also I should try to learn about life cycle of script (ready init and stuff like that)
https://docs.godotengine.org/en/latest/classes/class_%40gdscript.html#class-gdscript-annotation-export-exp-easing


