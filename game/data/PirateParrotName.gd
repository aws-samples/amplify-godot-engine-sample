@tool
extends Resource
class_name PirateParrotName

### PROPERTIES ###
@export var name: String
@export var title: String

### INITIALIZATION ###
func _init(p_name: String = "", p_title: String = "") -> void:
	name = p_name
	title = p_title

### PUBLIC METHODS ###
func get_full_name() -> String:
	if title:
		return "%s, %s" % [name, title]
	return name

### STATIC METHODS ###
static func generate(include_prefix: bool = true, include_title: bool = true, include_quirk: bool = false) -> PirateParrotName:
	var parrot = PirateParrotName.new()
	var name_parts = []
	
	# 50% chance for prefix if enabled
	if include_prefix and randf() < 0.5:
		name_parts.append(PREFIXES.pick_random())
	
	# Always add a first name
	name_parts.append(FIRST_NAMES.pick_random())
	
	parrot.name = " ".join(name_parts)
	
	# Add title or quirk (if enabled)
	if include_title:
		if include_quirk and randf() < 0.3:
			parrot.title = QUIRKS.pick_random()
		else:
			parrot.title = TITLES.pick_random()
	
	return parrot

static func generate_simple() -> PirateParrotName:
	return PirateParrotName.new(FIRST_NAMES.pick_random())

static func generate_quirky() -> PirateParrotName:
	var parrot = generate(true, false, false)
	parrot.title = QUIRKS.pick_random()
	return parrot

func _to_string() -> String:
	return get_full_name()

### STATIC DATA ###
static var PREFIXES := [
	"Captain", "Mr.", "Lady", "Sir", "Old", "Young", "Salty", "Fancy",
	"Admiral", "Professor", "Doctor", "Madame", "Lord", "Duke", "Count",
	"Inspector", "Colonel", "Chef", "First Mate"
]

static var FIRST_NAMES := [
	# Classic Parrot Names
	"Polly", "Squawk", "Cracker", "Feathers", "Beaky", "Rainbow", "Scuttle",
	
	# Food-Inspired Names
	"Mango", "Coconut", "Rum", "Biscuit", "Cookie", "Pickle", "Ginger",
	"Nutmeg", "Pepper", "Sugar", "Brandy", "Toffee", "Pretzel",
	
	# Piratey Names
	"Pegleg", "Patch", "Hook", "Doubloon", "Barnacle", "Plank", "Shipwreck",
	
	# Nautical Names
	"Anchor", "Rudder", "Compass", "Sextant", "Starboard", "Port", "Mizzen",
	
	# Personality Names
	"Sassy", "Grumpy", "Dizzy", "Loopy", "Swagger", "Trouble", "Rascal",
	
	# Color Names
	"Emerald", "Ruby", "Sapphire", "Jade", "Goldie", "Azure", "Crimson"
]

static var TITLES := [
	# Food-Related Titles
	"Destroyer of Crackers", "Biscuit Bandit", "Fruit Fiend", "Cookie Criminal",
	"Master of Munchies", "Snack Stealer", "Treat Tyrant",
	
	# Mischief Titles
	"Chaos Coordinator", "Minister of Mayhem", "Prince of Pranks",
	"Chief of Chatter", "Duke of Disorder", "Baron of Bedlam",
	"Master of Mischief", "Commander of Confusion",
	
	# Ship-Related Titles
	"Terror of the Topmast", "Menace of the Mainmast", "Scourge of the Sails",
	"Keeper of the Crow's Nest", "Guardian of the Galley",
	"Watcher of the Waves", "Navigator of Nonsense",
	
	# Treasure-Related Titles
	"Collector of Shiny Things", "Hoarder of Trinkets", "Seeker of Sparkles",
	"Keeper of Lost Keys", "Pilferer of Precious Things",
	
	# Sound-Related Titles
	"Master of Mimicry", "King of Cacophony", "Sultan of Squawks",
	"Lord of Loud Noises", "Champion of Chatter", "Virtuoso of Volume",
	
	# Fancy Titles
	"Most Distinguished Bird", "His Royal Squawkiness", "First Bird of the Fleet",
	"Grand Admiral of the Air", "Most Exalted Feathered One"
]

static var QUIRKS := [
	# Speech Quirks
	"who only speaks in Shakespeare quotes",
	"who knows too many sailor secrets",
	"who speaks three languages, all incorrectly",
	"who only whispers conspiracies",
	"who thinks he's teaching the crew French",
	
	# Food Quirks
	"who demands breakfast in bed",
	"who steals everyone's rum",
	"who only eats golden crackers",
	"who critiques the ship's cooking",
	"who hides biscuits in the captain's hat",
	
	# Behavioral Quirks
	"who thinks he's the real captain",
	"who's afraid of wooden legs",
	"who corrects everyone's grammar",
	"who tells tall tales to new crew members",
	"who organizes midnight dance parties",
	
	# Collection Quirks
	"who hoards shiny buttons",
	"who steals everyone's keys",
	"who collects lost earrings",
	"who builds nests out of maps",
	"who decorates the crow's nest",
	
	# Musical Quirks
	"who only sings opera",
	"who conducts invisible orchestras",
	"who remixes sea shanties",
	"who hums during battles",
	"who teaches shanties to mice",
	
	# Superstitious Quirks
	"who predicts the weather wrong",
	"who claims to see ghost ships",
	"who warns about nonexistent mermaids",
	"who blames everything on sea spirits",
	"who thinks the compass is haunted"
]
