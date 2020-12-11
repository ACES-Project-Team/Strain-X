extends Control

onready var healthOver= $HealthOver
onready var healthUnder = $HealthUnder
onready var updateTween = $UpdateTween
onready var pulseTween = $PulseTween

export (Color) var healthyColor = Color.green
export (Color) var cautionColor = Color.yellow
export (Color) var dangerColor = Color.red
export (Color) var pulseColor = Color.darkred
export (float, 0, 1, 0.05) var cautionZone = 0.5
export (float, 0, 1, 0.05) var dangerZone = 0.2
export (bool) var willPulse = false

func _on_health_updated(health):
	healthOver.value = health
	updateTween.interpolate_property(healthUnder, "value", healthUnder.value, health, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	updateTween.start()
	
	_assign_color(health)

func  _assign_color(health):
	if health == 0:
		pulseTween.set_active(false)
	elif health < healthOver.max_value * dangerZone:
		if willPulse == true:
			if !pulseTween.is_active():
				pulseTween.interpolate_property(healthOver, "tint_progress", pulseColor, dangerColor, 1.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
				pulseTween.start()
		else:
			healthOver.tint_progress = dangerColor
	else:
		pulseTween.set_active(false)
		if health < healthOver.max_value * cautionZone:
			healthOver.tint_progress = cautionColor
		else:
			healthOver.tint_progress = healthyColor

func _on_max_health_changed(max_health):
	healthOver.max_value = max_health
	healthUnder.max_value = max_health

