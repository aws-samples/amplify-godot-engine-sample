@tool
class_name PirateNationality
extends Resource

# Enums should be defined at the top and have clear documentation
enum Id {
	# European
	ENGLISH,      # English pirates, privateers, buccaneers
	FRENCH,       # French corsairs, flibustiers 
	DUTCH,        # Dutch privateers, zee roovers
	SPANISH,      # Spanish corsairs, renegados
	PORTUGUESE,   # Portuguese corsairs
	
	# Mediterranean  
	OTTOMAN,      # Ottoman Empire corsairs
	BARBARY,      # North African corsairs 
	GREEK,        # Greek maritime raiders
	VENETIAN,     # Venetian corsairs
	
	# Asian
	CHINESE,      # Chinese pirates, confederations
	JAPANESE,     # Japanese pirates, wokou
	MALAY,        # Malay maritime raiders
	BUGIS,        # Bugis maritime forces
	SULU,         # Sulu sultanate raiders
	
	# Indian Ocean
	GUJARATI,     # Indian western coast pirates
	MALABAR      # Malabar coast pirates
}

# Exported properties should be grouped together
@export var id: Id
@export var name: String
@export_multiline var description: String
@export var notable_figures: Array[String]
@export_multiline var color: String 
@export var colors: Array[Color]

# Static variables for each nationality
static var ENGLISH: PirateNationality
static var FRENCH: PirateNationality
static var DUTCH: PirateNationality
static var SPANISH: PirateNationality
static var PORTUGUESE: PirateNationality
static var OTTOMAN: PirateNationality
static var BARBARY: PirateNationality
static var GREEK: PirateNationality
static var VENETIAN: PirateNationality
static var CHINESE: PirateNationality
static var JAPANESE: PirateNationality
static var MALAY: PirateNationality
static var BUGIS: PirateNationality
static var SULU: PirateNationality
static var GUJARATI: PirateNationality
static var MALABAR: PirateNationality

# Static dictionary of all nationalities
static var ALL_NATIONALITIES

# Instance initialization
func _init(p_id = null, p_name = "", p_description = "", 
		  p_notable_figures: Array[String] = [], 
		  p_color = "",
		  p_colors: Array[Color] = []) -> void:
	id = p_id
	name = p_name
	description = p_description
	notable_figures = p_notable_figures
	color = p_color
	colors = p_colors

# Static initialization function
static func _static_init() -> void:
	# Initialize all nationality instances
	ENGLISH = PirateNationality.new(
		Id.ENGLISH,
		"English Pirates",
		"""English pirates and privateers were among the most notorious during the Golden Age...""",
		["Henry Morgan", "Bartholomew Roberts", "Edward Teach (Blackbeard)", "Sam Bellamy"],
		"""Primary colors: Royal naval red and pristine white...""",
		[Color("ff0000"), Color("ffffff"), Color("000080"), Color("ffd700")]
	)
	
	FRENCH = PirateNationality.new(
		Id.FRENCH,
		"French Pirates",
		"""French pirates and privateers, known as corsairs...""",
		["Jean Bart", "René Duguay-Trouin", "Jean-François Roberval"],
		"""Primary colors: Bourbon white with royal French blue...""",
		[Color("002395"), Color("ffffff"), Color("ed2939"), Color("ffd700")]
	)
	
	# Initialize remaining nationalities...
	
	# Initialize ALL_NATIONALITIES dictionary
	ALL_NATIONALITIES = {
		Id.ENGLISH: ENGLISH,
		Id.FRENCH: FRENCH,
		# Add other nationalities...
	}
