extends Control

var health = 500 setget set_health
var max_health = 500 setget set_max_health

onready var healthbar = $BossHealthBar

func set_health(value):
	health = clamp(value, 0, max_health)
	if healthbar != null:
		healthbar.text = "HP =" + str(health)

func set_max_health(value):
	max_health = max(value, 1)

func _ready():
	max_health = Stats.MAX_HEALTH
	health = Stats.HEALTH
	Stats.connect("health_changed", self, "set_health")
	
