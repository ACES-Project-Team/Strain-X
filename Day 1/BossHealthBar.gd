extends Control

onready var health_bar = $HealthBar
onready var update_tween = $UpdateTween

func _on_health_updated(health,amount):
	health_bar.value = health
	update_tween.interpolate_property(health_bar, "value", health_bar.value, health, 0.4, Tween.TRANS.SINE, Tween.EASE_IN_OUT)
	update_tween.start()
	
func on_max_health_updated(max_health):
	health_bar.max_valye = max_health
	
