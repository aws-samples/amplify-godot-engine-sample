@tool
extends Resource
class_name PirateCaptainName

# Instance variables
@export var first_name: String
@export var middle_name: String
@export var last_name: String
@export var title: String
@export var epithet: String
@export var nationality: PirateNationality
@export var base: PirateBase

# Generation probability constants
const MIDDLE_NAME_CHANCE := 0.3
const TITLE_CHANCE := 0.4
const EPITHET_CHANCE := 0.25

# Instance methods
func _init(p_first: String = "", p_middle: String = "", p_last: String = "", 
		p_title: String = "", p_epithet: String = "", 
		p_nationality: PirateNationality = null, p_base: PirateBase = null) -> void:
	first_name = p_first
	middle_name = p_middle
	last_name = p_last
	title = p_title
	epithet = p_epithet
	nationality = p_nationality
	base = p_base

func get_full_name() -> String:
	var name_parts = []
	
	if has_title():
		name_parts.append(title)
	
	name_parts.append(first_name)
	if has_middle_name():
		name_parts.append(middle_name)
	name_parts.append(last_name)
	
	var base_name = " ".join(name_parts)
	
	if has_epithet():
		return base_name + ", " + epithet
	
	return base_name

func get_base_name() -> String:
	var parts = []
	parts.append(first_name)
	if has_middle_name():
		parts.append(middle_name)
	parts.append(last_name)
	return " ".join(parts)

func get_nationality() -> PirateNationality:
	return nationality

func get_base() -> PirateBase:
	return base

func has_title() -> bool:
	return title != ""

func has_epithet() -> bool:
	return epithet != ""

func has_middle_name() -> bool:
	return middle_name != ""

func is_complete() -> bool:
	return first_name != "" and last_name != "" and nationality != null

func to_dictionary() -> Dictionary:
	return {
		"first_name": first_name,
		"middle_name": middle_name,
		"last_name": last_name,
		"title": title,
		"epithet": epithet,
		"nationality": nationality.id if nationality else null,
		"base": base.id if base else null
	}

func _to_string() -> String:
	return get_full_name()

# Static utility methods
static func get_first_names(nationality_id: PirateNationality.Id) -> Array[String]:
	return _get_names_data(nationality_id).first_names

static func get_middle_names(nationality_id: PirateNationality.Id) -> Array[String]:
	return _get_names_data(nationality_id).middle_names

static func get_last_names(nationality_id: PirateNationality.Id) -> Array[String]:
	return _get_names_data(nationality_id).last_names

static func get_titles(nationality_id: PirateNationality.Id) -> Array[String]:
	return _get_names_data(nationality_id).titles

static func get_epithets(_nationality_id: PirateNationality.Id) -> Array[String]:
	return BASE_EPITHETS

static func _get_names_data(nationality_id: PirateNationality.Id) -> NameData:
	return _NAMES_DATA.get(nationality_id, NameData.new([], [], [], []))

static func _get_random_from_array(array: Array) -> String:
	if array.is_empty():
		return ""
	return array[randi() % array.size()]

static func _format_epithet(epithet: String, base: PirateBase) -> String:
	if base == null:
		return ""
	return epithet.replace("{base}", base.name)

# Name generation methods
static func generate(p_nationality: PirateNationality, p_base: PirateBase = null) -> PirateCaptainName:
	var name = PirateCaptainName.new()
	name.nationality = p_nationality
	name.base = p_base
	
	var nat_id = p_nationality.id
	
	# Generate core name components
	name.first_name = _get_random_from_array(get_first_names(nat_id))
	name.last_name = _get_random_from_array(get_last_names(nat_id))
	
	if randf() < MIDDLE_NAME_CHANCE:
		name.middle_name = _get_random_from_array(get_middle_names(nat_id))
	
	if randf() < TITLE_CHANCE:
		name.title = _get_random_from_array(get_titles(nat_id))
	
	# Only generate epithet if we have a base
	if p_base != null and randf() < EPITHET_CHANCE:
		var base_epithet = _get_random_from_array(get_epithets(nat_id))
		name.epithet = _format_epithet(base_epithet, p_base)
	
	return name

static func generate_simple(p_nationality: PirateNationality, p_base: PirateBase = null) -> PirateCaptainName:
	return PirateCaptainName.new(
		_get_random_from_array(get_first_names(p_nationality.id)),
		"",
		_get_random_from_array(get_last_names(p_nationality.id)),
		"",
		"",
		p_nationality,
		p_base
	)

static func generate_full(p_nationality: PirateNationality, p_base: PirateBase = null) -> PirateCaptainName:
	var name = generate(p_nationality, p_base)
	var nat_id = p_nationality.id
	
	name.middle_name = _get_random_from_array(get_middle_names(nat_id))
	name.title = _get_random_from_array(get_titles(nat_id))
	
	if p_base != null:
		var base_epithet = _get_random_from_array(get_epithets(nat_id))
		name.epithet = _format_epithet(base_epithet, p_base)
	
	return name

# Name data structure
class NameData:
	var first_names: Array[String]
	var middle_names: Array[String]
	var last_names: Array[String]
	var titles: Array[String]
	
	func _init(p_first: Array[String], p_middle: Array[String], p_last: Array[String],
			p_titles: Array[String]) -> void:
		first_names = p_first
		middle_names = p_middle
		last_names = p_last
		titles = p_titles

# Static name data organized by nationality
static var _NAMES_DATA := {
	PirateNationality.Id.ENGLISH: NameData.new(
		# First names
		[
			"John", "William", "Edward", "Thomas", "James",
			"Henry", "Charles", "Richard", "George", "Robert",
			"Francis", "Christopher", "Bartholomew", "Samuel",
			"Benjamin", "Alexander", "Nicholas", "Daniel",
			"Joseph", "Matthew"
		],
		# Middle names
		[
			"'Black'", "'Red'", "'Lucky'", "'Old'", "'Mad'",
			"'Bloody'", "'Wild'", "'Cruel'", "'Young'", "'Bold'",
			"'Silent'", "'Swift'", "'Dark'", "'Fierce'", "'Grim'"
		],
		# Last names
		[
			"Morgan", "Drake", "Rackham", "Teach", "Roberts",
			"Kidd", "Bonnet", "Low", "England", "Vane",
			"Bellamy", "Taylor", "Halsey", "Phillips", "Worley",
			"Flint", "Hawkins", "Rogers", "Lynch", "Swan"
		],
		# Titles
		[
			"Captain", "Admiral", "Commodore", "Sir", "Lord",
			"Master", "Commander", "Chief", "Governor"
		]
	),

	PirateNationality.Id.FRENCH: NameData.new(
		# First names
		[
			"Jean", "François", "Pierre", "Jacques", "Louis",
			"Michel", "Antoine", "René", "Claude", "Henri",
			"André", "Philippe", "Robert", "Charles", "Marcel",
			"Guy", "Alain", "Bernard", "Paul", "Roger"
		],
		# Middle names
		[
			"'le Rouge'", "'le Noir'", "'le Grand'", "'le Terrible'",
			"'le Fou'", "'l'Ancien'", "'le Brave'", "'le Fort'",
			"'le Rapide'", "'le Sombre'", "'le Fier'", "'le Rusé'"
		],
		# Last names
		[
			"Laffite", "L'Olonnais", "Grammont", "Levasseur",
			"Montbars", "Cassard", "Bart", "Durand", "Dupuis",
			"Surcouf", "Ducasse", "Pellot", "Le Vasseur",
			"Douville", "Thurot", "Duguay", "Forbin", "Massiac"
		],
		# Titles
		[
			"Capitaine", "Commandant", "Chevalier", "Sieur",
			"Monsieur", "Marquis", "Comte", "Maître"
		]
	),

	PirateNationality.Id.DUTCH: NameData.new(
		# First names
		[
			"Hendrik", "Jan", "Piet", "Willem", "Cornelis",
			"Dirk", "Jacob", "Adriaan", "Simon", "Joost",
			"Frans", "Maarten", "Thomas", "Pieter", "Karel"
		],
		# Middle names
		[
			"'de Zwarte'", "'de Rode'", "'de Oude'", "'de Jonge'",
			"'de Wilde'", "'de Sterke'", "'de Grote'", "'de Snelle'",
			"'de Wijze'", "'de Stoute'", "'de Dappere'"
		],
		# Last names
		[
			"van Hoorn", "Janszoon", "Pietersen", "de Groot",
			"van der Zee", "Schouten", "van Gelder", "de Ruyter",
			"van Dort", "Corneliszoon", "de Witt", "van Utrecht"
		],
		# Titles
		[
			"Kapitein", "Admiraal", "Commandeur", "Schipper",
			"Heer", "Meester", "Bevelhebber"
		]
	),

	PirateNationality.Id.SPANISH: NameData.new(
		# First names
		[
			"Diego", "Juan", "Pedro", "Francisco", "Antonio",
			"Miguel", "Carlos", "José", "Fernando", "Luis",
			"Rodrigo", "Alfonso", "Manuel", "Alejandro", "Ramón"
		],
		# Middle names
		[
			"'el Negro'", "'el Rojo'", "'el Viejo'", "'el Bravo'",
			"'el Fuerte'", "'el Grande'", "'el Valiente'",
			"'el Sabio'", "'el Fiero'", "'el Noble'"
		],
		# Last names
		[
			"García", "Rodriguez", "Fernández", "López", "Martinez",
			"Sanchez", "Pérez", "González", "Ruiz", "Hernández",
			"Mendoza", "Torres", "Morales", "Ortiz", "Delgado"
		],
		# Titles
		[
			"Capitán", "Almirante", "Don", "Señor",
			"Comandante", "Gobernador", "Maestre"
		]
	),

	PirateNationality.Id.CHINESE: NameData.new(
		# First names
		[
			"Zhang", "Wang", "Li", "Chen", "Liu",
			"Yang", "Huang", "Wu", "Zhou", "Sun",
			"Zhao", "Cheng", "Lin", "Tang", "Xu"
		],
		# Middle names
		[
			"'Hai'", "'Long'", "'Feng'", "'Ming'",
			"'Jian'", "'Cheng'", "'Yong'", "'Wei'",
			"'Yu'", "'Heng'", "'Tao'"
		],
		# Last names
		[
			"Wei", "Yong", "Hai", "Feng", "Long",
			"Ming", "Jian", "Cheng", "Yuan", "Tao",
			"Gang", "Jun", "Xiang", "Hui", "Bin"
		],
		# Titles
		[
			"船長", "統領", "首領", "艦長",
			"將軍", "司令", "統帥"
		]
	),

	PirateNationality.Id.MALAY: NameData.new(
		# First names
		[
			"Raja", "Laksamana", "Tun", "Megat", "Hang",
			"Dato", "Sultan", "Panglima", "Awang", "Temenggung"
		],
		# Middle names
		[
			"'Laut'", "'Hitam'", "'Merah'", "'Putih'",
			"'Gagah'", "'Berani'", "'Sakti'", "'Perkasa'"
		],
		# Last names
		[
			"Tuah", "Jebat", "Lekir", "Kasturi", "Laksamana",
			"Ali", "Ibrahim", "Abdullah", "Rahman", "Hussein"
		],
		# Titles
		[
			"Laksamana", "Sultan", "Raja", "Panglima",
			"Dato", "Temenggung", "Kapitan"
		]
	),

	PirateNationality.Id.SULU: NameData.new(
		# First names
		[
			"Datu", "Sultan", "Rajah", "Amir", "Sharif",
			"Panglima", "Maharaja", "Tuan", "Hadji", "Orang"
		],
		# Middle names
		[
			"'Kaya'", "'Laksamana'", "'Laut'", "'Putih'",
			"'Hitam'", "'Muda'", "'Tua'", "'Perkasa'"
		],
		# Last names
		[
			"Kiram", "Sakilan", "Rasul", "Putih", "Abirin",
			"Julkarnain", "Salahuddin", "Maharajah", "Tupay"
		],
		# Titles
		[
			"Datu", "Sultan", "Panglima", "Maharaja",
			"Laksamana", "Tuan", "Orang"
		]
	),

	PirateNationality.Id.BARBARY: NameData.new(
		# First names
		[
			"Ali", "Murad", "Hassan", "Ibrahim", "Yusuf",
			"Salih", "Hamid", "Omar", "Mustafa", "Selim",
			"Ahmed", "Mehmed", "Ismail", "Khalil", "Mahmud"
		],
		# Middle names
		[
			"'Reis'", "'Rais'", "'Bey'", "'Dey'",
			"'Agha'", "'Kaid'", "'Kaptan'"
		],
		# Last names
		[
			"Barbarossa", "Dragut", "Reis", "Pasha",
			"al-Din", "al-Turki", "al-Jazairi", "al-Maghribi"
		],
		# Titles
		[
			"Reis", "Pasha", "Bey", "Dey",
			"Agha", "Kaid", "Kaptan"
		]
	)
}

# Shared epithets for all nationalities
const BASE_EPITHETS := [
	# Power and Control
	"Master of {base}",
	"Lord of {base}",
	"Ruler of {base}",
	"Commander of {base}",
	"Sovereign of {base}",
	"King of {base}",
	"Queen of {base}",
	
	# Protection and Defense
	"Guardian of {base}",
	"Defender of {base}",
	"Protector of {base}",
	"Shield of {base}",
	"Warden of {base}",
	
	# Fear and Intimidation
	"Terror of {base}",
	"Scourge of {base}",
	"Bane of {base}",
	"Doom of {base}",
	"Dread of {base}",
	"Fear of {base}",
	
	# Mystique and Legend
	"Ghost of {base}",
	"Phantom of {base}",
	"Shadow of {base}",
	"Specter of {base}",
	"Legend of {base}",
	"Mystery of {base}",
	
	# Strength and Prowess
	"Lion of {base}",
	"Tiger of {base}",
	"Wolf of {base}",
	"Dragon of {base}",
	"Hawk of {base}",
	"Eagle of {base}",
	
	# Authority and Control
	"Captain of {base}",
	"Admiral of {base}",
	"Warlord of {base}",
	"Chief of {base}",
	"Leader of {base}",
	
	# Fame and Reputation
	"Hero of {base}",
	"Champion of {base}",
	"Star of {base}",
	"Pride of {base}",
	"Glory of {base}",
	
	# Dominance and Power
	"Tyrant of {base}",
	"Overlord of {base}",
	"Emperor of {base}",
	"Conqueror of {base}",
	
	# Wisdom and Experience
	"Sage of {base}",
	"Elder of {base}",
	"Voice of {base}",
	"Oracle of {base}",
	
	# Loyalty and Leadership
	"Chieftain of {base}",
	"Leader of {base}",
	"Commander of {base}",
	"Marshal of {base}"
]
