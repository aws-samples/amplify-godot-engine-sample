extends Resource
class_name PirateNationality

enum Id {
	# European
	ENGLISH,        # English pirates, privateers, buccaneers
	FRENCH,         # French corsairs, flibustiers, buccaneers
	DUTCH,          # Dutch privateers, zee roovers
	SPANISH,        # Spanish corsairs, renegades
	PORTUGUESE,     # Portuguese corsairs, privateers
	
	# Mediterranean
	OTTOMAN,        # Ottoman Empire corsairs
	BARBARY,        # North African corsairs
	GREEK,          # Greek maritime raiders
	VENETIAN,       # Venetian corsairs
	
	# Asian
	CHINESE,        # Chinese pirates, confederations
	JAPANESE,       # Japanese pirates, wako
	MALAY,          # Malay maritime raiders
	BUGIS,          # Bugis maritime forces
	SULU,           # Sulu sultanate raiders
	
	# Indian Ocean
	GUJARATI,       # Indian western coast pirates
	MALABAR        # Malabar coast pirates
}

# Nationality instance variables
@export var id: Id
@export var name: String
@export_multiline var description: String
@export var notable_figures: Array[String]
@export_multiline var color: String  # New color description attribute
@export var colors: Array[Color]

func _init(p_id = null, p_name = "", p_description = "", 
		  p_notable_figures: Array[String] = [], 
		  p_color = "",  # New color description parameter
		  p_colors: Array[Color] = []) -> void:
	id = p_id
	name = p_name
	description = p_description
	notable_figures = p_notable_figures
	color = p_color    # Initialize new color description
	colors = p_colors



static var ENGLISH := PirateNationality.new(
	Id.ENGLISH,
	"English Pirates",
	"""
	English pirates and privateers were among the most notorious during the Golden Age of Piracy.
	Operating with and without letters of marque, they were particularly active in the Caribbean
	and along the American eastern seaboard. English pirates developed sophisticated codes of
	conduct and were instrumental in establishing the 'pirate republic' in Nassau.
	""",
	[
		"Henry Morgan",
		"Bartholomew Roberts",
		"Edward Teach (Blackbeard)",
		"Sam Bellamy",
		"John Hawkins"
	],
	"""
	Primary colors: Royal naval red and pristine white dominate English vessels
	Clothing palette: Dark navy coats with gold trim, white breeches, black tricorn hats
	Flag designs: Black field with white or gold skeletal motifs
	Sail appearance: Weathered white canvas with red crosses when flying English colors
	Color mood: Bold and imperial
	""",
	[
		Color("ff0000"),  # Royal Navy Red
		Color("ffffff"),  # English White
		Color("000080"),  # Naval Blue
		Color("ffd700")   # Royal Gold
	]
)

static var FRENCH := PirateNationality.new(
	Id.FRENCH,
	"French Pirates and Corsairs",
	"""
	French pirates and privateers, known as corsairs or flibustiers in the Caribbean,
	were renowned for their skilled seamanship and complex relationship with the French crown.
	They operated extensively in the Caribbean and along the African coast, often with
	official letters of marque.
	""",
	[
		"Jean Bart",
		"René Duguay-Trouin",
		"Jean-François Roberval",
		"Daniel Montbars",
		"François l'Olonnais"
	],
	"""
	Primary colors: Bourbon white with royal French blue accents
	Clothing palette: Fine blue coats with white and gold trim, white naval breeches
	Flag designs: White field with golden fleur-de-lis for privateers
	Sail appearance: Bright white canvas with blue fleur-de-lis markings
	Color mood: Elegant and regal
	""",
	[
		Color("002395"),  # French Royal Blue
		Color("ffffff"),  # Bourbon White
		Color("ed2939"),  # French Naval Red
		Color("ffd700")   # Royal Gold
	]
)

static var DUTCH := PirateNationality.new(
	Id.DUTCH,
	"Dutch Pirates and Privateers",
	"""
	Dutch pirates and privateers, including the famous 'Sea Beggars' and Dutch East India Company
	(VOC) privateers, were highly organized and well-equipped. They operated globally, from the
	Caribbean to the East Indies, often blurring the line between legitimate trade and piracy.
	""",
	[
		"Piet Heyn",
		"Cornelis Jol",
		"Willem Janszoon",
		"Simon de Danser",
		"Claes Compaen"
	],
	"""
	Primary colors: Dutch orange and deep sea blue define their vessels
	Clothing palette: Practical brown leathers with bright orange sashes
	Flag designs: Horizontal tricolor of orange, white, and blue for VOC ships
	Sail appearance: Off-white canvas with distinctive red VOC markings
	Color mood: Practical and mercantile
	""",
	[
		Color("f36c21"),  # Dutch Orange
		Color("21468b"),  # Dutch Blue
		Color("ffffff"),  # Sail White
		Color("8b4513")   # Leather Brown
	]
)

static var SPANISH := PirateNationality.new(
	Id.SPANISH,
	"Spanish Corsairs",
	"""
	Spanish corsairs and privateers operated throughout the Caribbean and Mediterranean,
	primarily defending Spanish interests against other maritime powers. They were particularly
	active in protecting the Spanish Main and the treasure fleet routes.
	""",
	[
		"Miguel Enríquez",
		"Diego el Mulato",
		"Lorenzo de Graff",
		"Juan Corso",
		"Francisco de Luján"
	],
	"""
	Primary colors: Imperial Spanish crimson and gold dominate their ships
	Clothing palette: Rich burgundy coats with elaborate gold embroidery
	Flag designs: Crimson and gold with the Habsburg cross for official vessels
	Sail appearance: Sun-bleached white with distinctive red Cross of Burgundy
	Color mood: Imperial and ornate
	""",
	[
		Color("aa151b"),  # Spanish Crimson
		Color("f1bf00"),  # Habsburg Gold
		Color("800000"),  # Deep Burgundy
		Color("ffffff")   # Castilian White
	]
)

static var PORTUGUESE := PirateNationality.new(
	Id.PORTUGUESE,
	"Portuguese Corsairs",
	"""
	Portuguese corsairs operated along their empire's trade routes, from Brazil to India.
	They were particularly active in defending Portuguese interests against rival European
	powers and local Asian maritime forces.
	""",
	[
		"Bartolomeu Português",
		"Fernão Mendes Pinto",
		"Paulo Dias de Novais",
		"Duarte Pacheco Pereira",
		"António de Faria"
	],
	"""
	Primary colors: Portuguese green with blood red accents
	Clothing palette: White linen with green trim and gold embroidery
	Flag designs: White and green with royal coat of arms
	Sail appearance: White canvas with distinctive green crosses
	Color mood: Imperial and adventurous
	""",
	[
		Color("006600"),  # Portuguese Green
		Color("ff0000"),  # Royal Red
		Color("ffffff"),  # Royal White
		Color("ffd700")   # Crown Gold
	]
)

static var OTTOMAN := PirateNationality.new(
	Id.OTTOMAN,
	"Ottoman Corsairs",
	"""
	Ottoman corsairs were powerful naval forces in the Mediterranean and Red Sea. Operating
	with imperial sanction, they played a crucial role in Ottoman naval strategy and trade
	control. Their influence extended from the Barbary Coast to the Indian Ocean.
	""",
	[
		"Hayreddin Barbarossa",
		"Turgut Reis",
		"Uluç Ali Reis",
		"Kemal Reis",
		"Piri Reis"
	],
	"""
	Primary colors: Ottoman crimson with emerald green accents
	Clothing palette: Rich silk robes in deep reds with gold embroidery
	Flag designs: Red field with white crescent and star
	Sail appearance: Weather-stained canvas with green or red crescents
	Color mood: Rich and imperial
	""",
	[
		Color("e30a17"),  # Ottoman Red
		Color("00af66"),  # Ottoman Green
		Color("ffd700"),  # Sultan's Gold
		Color("ffffff")   # Crescent White
	]
)

static var BARBARY := PirateNationality.new(
	Id.BARBARY,
	"Barbary Corsairs",
	"""
	The Barbary corsairs were powerful privateers and pirates operating from North Africa.
	They conducted raids throughout the Mediterranean and into the Atlantic, from bases in
	Morocco, Algeria, Tunisia, and Tripoli.
	""",
	[
		"Murad Reis",
		"Dragut",
		"Ali Bitchin",
		"Süleyman Reis",
		"Yusuf Karamanli"
	],
	"""
	Primary colors: Islamic green with bold red accents
	Clothing palette: White flowing robes with colorful silk sashes
	Flag designs: Green fields with scimitars and crescents in white
	Sail appearance: Sun-bleached canvas with distinctive green markings
	Color mood: Bold and fierce
	""",
	[
		Color("006233"),  # Islamic Green
		Color("ce1126"),  # Barbary Red
		Color("ffffff"),  # Desert White
		Color("ffd700")   # Crescent Gold
	]
)

static var CHINESE := PirateNationality.new(
	Id.CHINESE,
	"Chinese Pirates",
	"""
	Chinese pirates operated extensively along the China coast and in Southeast Asian waters.
	They formed large confederations and sophisticated organizations, sometimes commanding
	hundreds of ships. They were particularly powerful during the late Ming and early Qing
	dynasties.
	""",
	[
		"Cheng I",
		"Cheng I Sao",
		"Cheung Po Tsai",
		"Cai Qian",
		"Shap Ng-tsai"
	],
	"""
	Primary colors: Imperial red and rich gold define their vessels
	Clothing palette: Black silk robes with elaborate dragon embroidery
	Flag designs: Red fields with black dragons or golden symbols
	Sail appearance: Rich red-brown bamboo sails with black markings
	Color mood: Dynamic and imperial
	""",
	[
		Color("de2910"),  # Imperial Red
		Color("ffd700"),  # Dynasty Gold
		Color("000000"),  # Ink Black
		Color("8b4513")   # Bamboo Brown
	]
)

static var JAPANESE := PirateNationality.new(
	Id.JAPANESE,
	"Japanese Wokou",
	"""
	The Wokou (Japanese pirates) were active in the seas of East Asia, particularly during
	the Ming Dynasty. Despite their name, they included Chinese, Korean, and Japanese sailors,
	engaging in both piracy and illegal trade throughout the region.
	""",
	[
		"Wang Zhi",
		"Matsura Takanobu",
		"Murakami Takeyoshi",
		"Noshima Murakami",
		"So Yoshitoshi"
	],
	"""
	Primary colors: Deep vermillion red with ink black accents
	Clothing palette: Black lacquered armor with red silk bindings
	Flag designs: Black field with bold red mon (family crests)
	Sail appearance: Natural bamboo with stark black geometric patterns
	Color mood: Bold and martial
	""",
	[
		Color("bc002d"),  # Vermillion Red
		Color("000000"),  # Ink Black
		Color("ffffff"),  # Pure White
		Color("b4533c")   # Copper Brown
	]
)

static var MALAY := PirateNationality.new(
	Id.MALAY,
	"Malay Pirates",
	"""
	Malay pirates operated throughout the Malay Archipelago, particularly in the Strait of Malacca.
	They combined traditional maritime skills with intimate knowledge of local waters, making them
	formidable in the region. Their operations were often connected to local sultanates.
	""",
	[
		"Raja Laut",
		"Tengku Long",
		"Raja Haji",
		"Sultan Mahmud",
		"Panglima Awang"
	],
	"""
	Primary colors: Royal yellow with deep ocean blue accents
	Clothing palette: Rich silk sarongs in yellow and green patterns
	Flag designs: Yellow crescents on dark blue fields
	Sail appearance: Woven palm fiber with traditional geometric patterns
	Color mood: Regal and tropical
	""",
	[
		Color("010066"),  # Royal Blue
		Color("ffcc00"),  # Sultan's Yellow
		Color("009900"),  # Jungle Green
		Color("ffffff")   # Pearl White
	]
)

static var BUGIS := PirateNationality.new(
	Id.BUGIS,
	"Bugis Maritime Raiders",
	"""
	The Bugis were skilled maritime traders and raiders from Sulawesi who operated throughout
	the Indonesian archipelago. Known for their fierce independence and naval expertise, they
	established powerful trading and raiding networks across Southeast Asian waters.
	""",
	[
		"Arung Palakka",
		"La Ma'dukelleng",
		"Daeng Parani",
		"To Apa Balla",
		"Amanna Gappa"
	],
	"""
	Primary colors: Blood red and pitch black dominate their vessels
	Clothing palette: Black silk sarongs with red and gold weaving
	Flag designs: Red and black fields with traditional Bugis symbols
	Sail appearance: Dark woven fiber with red geometric patterns
	Color mood: Fierce and traditional
	""",
	[
		Color("ff0000"),  # Blood Red
		Color("000000"),  # Night Black
		Color("ffff00"),  # Sacred Gold
		Color("ffffff")   # Pearl White
	]
)

static var GUJARATI := PirateNationality.new(
	Id.GUJARATI,
	"Gujarati Maritime Forces",
	"""
	Gujarati maritime forces operated along India's western coast, combining trade with
	occasional raiding. They were particularly active in the Arabian Sea and were known
	for their sophisticated naval organization and shipbuilding capabilities.
	""",
	[
		"Kanhoji Angre",
		"Sekhoji Angre",
		"Tulaji Angre",
		"Sandal Koli",
		"Raja Koli"
	],
	"""
	Primary colors: Saffron orange with deep navy accents
	Clothing palette: White cotton with rich saffron and maroon details
	Flag designs: Saffron fields with traditional Hindu symbols
	Sail appearance: Natural cotton with orange and maroon borders
	Color mood: Rich and spiritual
	""",
	[
		Color("ff9933"),  # Sacred Saffron
		Color("138808"),  # Ocean Green
		Color("ffffff"),  # Pure White
		Color("800000")   # Deep Maroon
	]
)

static var MALABAR := PirateNationality.new(
	Id.MALABAR,
	"Malabar Pirates",
	"""
	The Malabar pirates operated along India's southwestern coast, challenging both European
	and local shipping. They were skilled navigators who used the monsoon patterns to their
	advantage and maintained complex relationships with local rulers.
	""",
	[
		"Kunjali Marakkar I",
		"Kunjali Marakkar IV",
		"Kurup",
		"Ali Raja",
		"Mappila Raiders"
	],
	"""
	Primary colors: Forest green with spice orange accents
	Clothing palette: White cotton robes with green and gold trim
	Flag designs: Green fields with golden crescents or tigers
	Sail appearance: Natural cotton with green geometric borders
	Color mood: Tropical and mysterious
	""",
	[
		Color("00923f"),  # Forest Green
		Color("ff4f00"),  # Spice Orange
		Color("ffffff"),  # Cotton White
		Color("000000")   # Night Black
	]
)

static var GREEK := PirateNationality.new(
	Id.GREEK,
	"Greek Maritime Raiders",
	"""
	Greek pirates and privateers operated throughout the Aegean and Eastern Mediterranean,
	drawing on ancient maritime traditions. They were particularly active during periods
	of Ottoman decline and played significant roles in regional commerce and conflict.
	""",
	[
		"Laskarina Bouboulina",
		"Andreas Miaoulis",
		"Constantine Kanaris",
		"Nikolaos Apostolis",
		"Dimitrios Papanikolis"
	],
	"""
	Primary colors: Mediterranean blue with classical white
	Clothing palette: White fustanellas with blue or black vests
	Flag designs: Blue and white crosses or ancient Greek motifs
	Sail appearance: White canvas with distinctive blue crosses
	Color mood: Classical and bright
	""",
	[
		Color("0d5eaf"),  # Aegean Blue
		Color("ffffff"),  # Marble White
		Color("d4af37"),  # Ancient Gold
		Color("000000")   # Obsidian Black
	]
)

static var VENETIAN := PirateNationality.new(
	Id.VENETIAN,
	"Venetian Corsairs",
	"""
	Venetian maritime forces operated throughout the Mediterranean, protecting trade
	routes and competing with Ottoman and other powers. They combined official naval
	operations with privateering activities to maintain Venice's maritime dominance.
	""",
	[
		"Vittorio Pisani",
		"Angelo Emo",
		"Lazzaro Mocenigo",
		"Francesco Morosini",
		"Marco Antonio Bragadin"
	],
	"""
	Primary colors: Venetian red with rich gold accents
	Clothing palette: Black velvet with gold brocade and red trim
	Flag designs: Gold winged lion of St. Mark on red fields
	Sail appearance: White canvas with the lion of St. Mark
	Color mood: Wealthy and sophisticated
	""",
	[
		Color("c1272d"),  # Venetian Red
		Color("ffd700"),  # Merchant Gold
		Color("000080"),  # Maritime Blue
		Color("ffffff")   # Lagoon White
	]
)

static var SULU := PirateNationality.new(
	Id.SULU,
	"Sulu Maritime Forces",
	"""
	The Sulu pirates, operating from the Sulu Archipelago, were a significant maritime force
	in Southeast Asian waters. Connected to the Sulu Sultanate, they conducted raids throughout
	the Philippines, Eastern Borneo, and the Celebes Sea regions.
	""",
	[
		"Sultan Jamalul Kiram",
		"Datu Bantilan",
		"Captain Toring",
		"Datu Pula",
		"Sultan Pulalun"
	],
	"""
	Primary colors: Forest green with golden yellow accents
	Clothing palette: Green and gold silk with intricate patterns
	Flag designs: Green fields with golden kris and crescent
	Sail appearance: Woven fiber with green and gold patterns
	Color mood: Royal and tropical
	""",
	[
		Color("008000"),  # Sultanate Green
		Color("ffd700"),  # Royal Gold
		Color("ffffff"),  # Pearl White
		Color("000000")   # Shadow Black
	]
)

# Collection of all pirate nationalities
static var ALL_NATIONALITIES : Dictionary = {
	# European
	Id.ENGLISH: ENGLISH,
	Id.FRENCH: FRENCH,
	Id.DUTCH: DUTCH,
	Id.SPANISH: SPANISH,
	Id.PORTUGUESE: PORTUGUESE,
	
	# Mediterranean
	Id.OTTOMAN: OTTOMAN,
	Id.BARBARY: BARBARY,
	Id.GREEK: GREEK,
	Id.VENETIAN: VENETIAN,
	
	# Asian
	Id.CHINESE: CHINESE,
	Id.JAPANESE: JAPANESE,
	Id.MALAY: MALAY,
	Id.BUGIS: BUGIS,
	Id.SULU: SULU,
	
	# Indian Ocean
	Id.GUJARATI: GUJARATI,
	Id.MALABAR: MALABAR
}
