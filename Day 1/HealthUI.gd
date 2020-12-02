extends Control

var healthBar = 150 setget set_healthBar
var max_healthBar = 150 setget set_max_healthBar

onready var label = $Label

func set_healthBar(value):
	healthBar = clamp(value, 0, max_healthBar)

func set_max_healthBar(value):
	max_healthBar = max(value, 1)

