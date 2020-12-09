extends Control

onready var health_bar = $HealthBar
onready var update_tween = $Tween

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow 
export (Color) var danger_color = Color.red 
export (float, 0,1, 0.05) var caution_zone = 0.5
export (float, 0,1, 0.05) var danger_zone = 0.2

func _on_health_updated(health, amount): 
	health_bar.value = health 
	update_tween.interpolate_property(health_bar, "value", health_bar.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	update_tween.start()
	
	_assign_color(health)
	
func _assign_color(health):
	if health < health_bar.max_value * danger_zone:
		health_bar.tint_progress = danger_color
	elif health < health_bar.max_value * caution_zone:
		health_bar.tint_progress = caution_color 
	else:
		health_bar.tint_progress = healthy_color
	
	
	
func _on_max_health_updated(max_health):
	health_bar.max_value = max_health
	
	