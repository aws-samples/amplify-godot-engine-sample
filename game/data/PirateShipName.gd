@tool
extends Resource
class_name PirateShipName

@export var name: String
@export var prefix: String
@export var epithet: String
@export var nationality: PirateNationality
@export var water: PirateWater

# Generation chance constants
const PREFIX_CHANCE := 0.8
const EPITHET_CHANCE := 0.3

func _init(p_name: String = "",
		p_prefix: String = "",
		p_epithet: String = "",
		p_nationality: PirateNationality = null,
		p_water: PirateWater = null) -> void:
	
	name = p_name
	prefix = p_prefix
	epithet = p_epithet
	nationality = p_nationality
	water = p_water

static func get_nationality_prefixes(nationality_id: PirateNationality.Id) -> Array[String]:
	return (_NATIONALITY_DATA.get(nationality_id, NationalityData.new([], [])) as NationalityData).prefixes

static func get_nationality_names(nationality_id: PirateNationality.Id) -> Array[String]:
	return (_NATIONALITY_DATA.get(nationality_id, NationalityData.new([], [])) as NationalityData).names

static func _get_random_from_array(array: Array) -> String:
	if array.is_empty():
		return ""
	return array[randi() % array.size()]

static func generate(p_nationality: PirateNationality, p_water: PirateWater) -> PirateShipName:
	var ship = PirateShipName.new()
	ship.nationality = p_nationality
	ship.water = p_water
	
	# Get base name from nationality names
	ship.name = _get_random_from_array(get_nationality_names(p_nationality.id))
	
	# Add prefix with 80% chance
	if randf() < PREFIX_CHANCE:
		ship.prefix = _get_random_from_array(get_nationality_prefixes(p_nationality.id))
	
	# Add epithet with 30% chance using water name
	if randf() < EPITHET_CHANCE:
		var epithet_pattern = _get_random_from_array(_EPITHET_PATTERNS)
		ship.epithet = epithet_pattern % p_water.name
	
	return ship

func get_full_name() -> String:
	var parts = []
	if prefix:
		parts.append(prefix)
	parts.append(name)
	if epithet:
		parts.append(epithet)
	return " ".join(parts)

func _to_string() -> String:
	return get_full_name()

class NationalityData:
	var prefixes: Array[String]
	var names: Array[String]
	
	func _init(p_prefixes: Array[String], p_names: Array[String]) -> void:
		prefixes = p_prefixes
		names = p_names

# Nationality-specific naming data
static var _NATIONALITY_DATA := {
	PirateNationality.Id.BARBARY: NationalityData.new(
		["Barbary", "Desert", "Corsair", "Crescent", "Southern"],
		["Revenge", "Victory", "Fortune", "Destiny", "Pride", "Conquest", "Glory"]
	),
	PirateNationality.Id.ENGLISH: NationalityData.new(
		["Royal", "English", "British", "Crown's", "Sovereign"],
		["Adventure", "Victory", "Fortune", "Triumph", "Sovereign", "Conquest", "Glory"]
	),
	PirateNationality.Id.FRENCH: NationalityData.new(
		["French", "Royal", "Noble", "Maritime", "Grand"],
		["Victoire", "Fortune", "Triomphe", "Conquistador", "Gloire", "Destin"]
	),
	PirateNationality.Id.DUTCH: NationalityData.new(
		["Dutch", "Trading", "Merchant", "Golden", "Sea"],
		["Fortuin", "Overwinning", "Wraak", "Vrijheid", "Eendragt", "Geluk"]
	),
	PirateNationality.Id.SPANISH: NationalityData.new(
		["Spanish", "Royal", "Imperial", "Golden", "Sovereign"],
		["Victoria", "Fortuna", "Conquista", "Trinidad", "Venganza", "Gloria"]
	),
	PirateNationality.Id.PORTUGUESE: NationalityData.new(
		["Portuguese", "Royal", "Trading", "Colonial", "Imperial"],
		["Vitória", "Fortuna", "Vingança", "Trindade", "Glória", "Destino"]
	),
	PirateNationality.Id.CHINESE: NationalityData.new(
		["Eastern", "Dragon", "Imperial", "Jade", "Dynasty"],
		["Dragon", "Phoenix", "Tiger", "Fortune", "Victory", "Destiny"]
	),
	PirateNationality.Id.JAPANESE: NationalityData.new(
		["Rising Sun", "Eastern", "Imperial", "Samurai", "Shogun"],
		["Conquest", "Victory", "Fortune", "Dragon", "Honor", "Glory"]
	),
	PirateNationality.Id.MALAY: NationalityData.new(
		["Eastern", "Spice", "Island", "Trading", "Tropical"],
		["Victory", "Fortune", "Destiny", "Pride", "Spirit", "Glory"]
	),
	PirateNationality.Id.SULU: NationalityData.new(
		["Sultan's", "Island", "Southern", "Warrior", "Sea"],
		["Victory", "Fortune", "Revenge", "Pride", "Glory", "Conquest"]
	)
}

# Ship-specific epithet patterns
static var _EPITHET_PATTERNS := [
	# Fearsome reputation
	"Scourge of %s",
	"Terror of %s",
	"Dread of %s",
	"Horror of %s",
	
	# Supernatural associations
	"Phantom of %s",
	"Ghost Ship of %s",
	"Haunting Shadow of %s",
	"Spectral Terror of %s",
	
	# Speed and elusiveness
	"Swift Shadow of %s",
	"Unseen Hunter of %s",
	"Dancing Wind of %s",
	"Storm Runner of %s",
	
	# Combat prowess
	"Untamed Fury of %s",
	"Warship of %s",
	"Battle Cry of %s",
	"Iron Fist of %s",
	
	# Mystical/Natural forces
	"Storm Bringer of %s",
	"Tempest of %s",
	"Thunder of %s",
	"Lightning of %s",
	
	# Hunting/Predatory
	"Sea Wolf of %s",
	"Ocean Hawk of %s",
	"Silent Hunter of %s",
	"Night Stalker of %s",
	
	# Mythological
	"Sea Dragon of %s",
	"Kraken of %s",
	"Leviathan of %s",
	"Sea Serpent of %s",
	
	# Fortune/Fate
	"Curse of %s",
	"Dark Fate of %s",
	"Doom Bringer of %s",
	"Black Destiny of %s",
	
	# Environmental
	"Black Storm of %s",
	"Red Dawn of %s",
	"Dark Tide of %s",
	"Raging Storm of %s"
]
