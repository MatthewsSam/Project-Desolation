extends CollisionShape

#Global Vars
#Attacks
#export var hitTagName = ""
#export(NodePath) var attackInstance
#export var attacksPerSecond = 5
#var attackRate #Set to 1/APS

#Health
export var maxHealth = 100
export var currentHealth = 80
export var damageModification = 1.0
export var isAlive = true
export var destructionWait = 10.0

#Regen
export var hasRegen = true
export var regenTick = 5.0
export var regenAmount = 5
var regenTimer = 0.0



#Script Functions
func setRegenState(var state):
	hasRegen = state




func setLiving(var state):
	isAlive = state




func modifyHealth(var amount):
	if(!isAlive):
		return
	
	if(amount < 0):
		amount = amount * damageModification
	
	currentHealth += amount
	
	if(currentHealth > maxHealth):
		currentHealth = maxHealth
	
	if(currentHealth <= 0):
		currentHealth = 0
		setRegenState(false)
		setLiving(false)
	
	print("Health modified. Current health: %d." % currentHealth)




func regenHealth():
	if(!hasRegen or currentHealth == maxHealth):
		return
	
	regenTimer -= get_process_delta_time()
	
	if regenTimer <= 0.0:
		regenTimer = regenTick
		
		if(currentHealth < maxHealth):
			currentHealth += regenAmount
			if(currentHealth >= maxHealth):
				currentHealth = maxHealth
				print("HP recovered to max. Regen toggled off till damaged.")
				return
			
			print("Regen tick over max. %d added to health. " % regenAmount)
			print("Current health: %d" % currentHealth)
	
	



#Engine Functions

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_key_pressed(KEY_J):
		modifyHealth(-1)
		print(currentHealth)
	
	regenHealth()

