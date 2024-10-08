extends Area2D

var Damage = 0
#PotionType structure = [protection, endurance, Freeze, burn, Poison]
var PotionType = null
var Effects = [0, 0, 0]


@onready var PoisonParticles = $PoisonParticles
@onready var FreezeParticles = $FreezeParticles
@onready var BurnParticles = $BurnParticles
@onready var ProtectionParticles = $ProtectionParticles
@onready var GlassParticles = $GlassParticles
@onready var HealArea = $HealArea


func _ready():
	if PotionType[0]>0:
		set_collision_layer_value(3, true)
		set_collision_layer_value(6, false)
		set_collision_mask_value(1,  false)
		Damage *= 0.7
	if PotionType[0]>1:
		HealArea.set_collision_layer_value(3, true)
		HealArea.set_collision_mask_value(1,true)
		
	
	$Timer.start(5+PotionType[1])
	SetVisualEffects()

	for i in range(2, 5):
		Effects[i-2] = PotionType[i]

func SetVisualEffects():
	var amount: int = (PotionType[1]+1)*100
	var particleTypeNum: int = 0
	var activeTypes = []
	for i in range(0,len(PotionType)):
		if PotionType[i]>0:
			particleTypeNum += 1
			activeTypes.append(i)
	@warning_ignore("integer_division")
	var amountPerParticle = roundi(amount/max(particleTypeNum, 1)) 
	SetParticleSettings(activeTypes, amountPerParticle)


func SetParticleSettings(activeTypes, amount):
	for i in activeTypes:
		match i:
			0:
				ProtectionParticles.emitting = true
				ProtectionParticles.amount = amount
			1:
				GlassParticles.emitting = true
				GlassParticles.amount = amount
			2:
				FreezeParticles.emitting = true
				FreezeParticles.amount = amount
			3:
				BurnParticles.emitting = true
				BurnParticles.amount = amount
			4:
				PoisonParticles.emitting = true
				PoisonParticles.amount = amount
	


func OnTimerTimeout():
		queue_free()
	
func OnBodyEntered(body):
		if "Hit" in body:
			body.Hit(self, Damage, Effects)
		
	


func OnHealAreaBodyEntered(body):
	if "Heal" in body:
		body.Heal(20*PotionType[0])
