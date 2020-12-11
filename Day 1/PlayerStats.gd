extends Node

export var MAX_HEALTH = 100 setget set_max_health
var HEALTH = MAX_HEALTH setget set_health

signal no_health 

signal health_changed(value)
signal max_health_changed(value)

func set_max_health(max_health):
	MAX_HEALTH = max_health 
	self.HEALTH = min(HEALTH, MAX_HEALTH)
	emit_signal("max_health_changed", MAX_HEALTH)

func set_health(health):
	HEALTH = health
	emit_signal("health_changed", HEALTH)
	if HEALTH <= 0:
		emit_signal("no_health")
		_GameOver()

func _ready():
	self.HEALTH = MAX_HEALTH

func _GameOver():
		get_tree().change_scene_to(load("res://GameOVer.tscn"))
