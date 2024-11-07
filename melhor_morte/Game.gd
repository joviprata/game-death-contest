extends Node

@onready var players = {
	"0": {
		viweport = $HBoxContainer/SubViewportContainer/SubViewport,
		camera = $HBoxContainer/SubViewportContainer/SubViewport/Camera2D,
		player = $HBoxContainer/SubViewportContainer/SubViewport/Node2D/CharacterBody2D
	},
	
	"1": {
		viweport = $HBoxContainer/SubViewportContainer2/SubViewport,
		camera = $HBoxContainer/SubViewportContainer2/SubViewport/Camera2D,
		player = $HBoxContainer/SubViewportContainer/SubViewport/Node2D/CharacterBody2D2
	}
}

func _ready() -> void:
	players["1"].viewport.world = players["0"].viewport.world_2d
