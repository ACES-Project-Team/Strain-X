extends Control

var healthBar = 150 setget set_healthBar
var max_healthBar = 150 setget set_max_healthBar

onready var HealthBarUIFull = $HealthBarUIFull
onready var HealthBarUIEmpty = $HealthBarUIEmpty

func set_healthBar(value):
	healthBar = clamp(value, 0, max_healthBar)
	if HealthBarUIFull != null:
		HealthBarUIFull.rect_size.x = healthBar * 15
	
	
func set_max_healthBar(value):
	max_healthBar = max(value, 1)
	self.healthBar = min(healthBar, max_healthBar)
	if HealthBarUIEmpty != null:
		HealthBarUIEmpty.rect_size.x = max_healthBar * 15
func _ready():
	self.max_healthBar = PlayerStats.MAX_HEALTH
	self.healthBar = PlayerStats.HEALTH
	PlayerStats.connect("health_changed", self, "set_healthBar")
	PlayerStats.connect("max_health_changed", self, "set_max_healthBar")
