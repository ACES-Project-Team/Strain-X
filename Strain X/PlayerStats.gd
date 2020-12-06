extends Node

export var MAX_HEALTH = 1 setget set_max_health
var HEALTH = MAX_HEALTH setget set_health

signal no_health 

signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	MAX_HEALTH = value 
	self.HEALTH = min(HEALTH,MAX_HEALTH)	
	emit_signal("max_health_changed",MAX_HEALTH)

func set_health(value):
	HEALTH = value
	emit_signal("health_changed",HEALTH)
	if HEALTH <= 0:
		emit_signal("no_health")

func _ready():
	self.HEALTH = MAX_HEALTH
