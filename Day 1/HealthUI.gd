extends Control

var healthBar = 150 setget set_healthBar
var max_healthBar = 150 setget set_max_healthBar

func set_healthBar(value):
	healthBar = clamp(value, 0, max_healthBar)
	if label != null:
	
func set_max_healthBar(value):
	max_healthBar = max(value, 1)

func _ready():
	self.max_healthBar = PlayerStats.MAX_HEALTH
	self.healthBar = PlayerStats.HEALTH
	PlayerStats.connect("health_changed", self, "set_healthBar")
