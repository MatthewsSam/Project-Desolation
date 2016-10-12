extends Spatial

export var animation = ""

func _ready():
	get_node("anime").play(animation)
	pass
