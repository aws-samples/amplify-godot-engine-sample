class_name PirateRegion
extends Resource

enum Id {
	# Americas
	CARIBBEAN_SEA,      # Caribbean waters
	SPANISH_MAIN,       # South American coast
	
	# Europe
	MEDITERRANEAN,      # Mediterranean Sea
	NORTH_SEA,         # Northern European waters
	
	# East & Southeast Asia
	SOUTH_CHINA_SEA,   # Chinese waters
	MALACCA_STRAIT,    # Malay Archipelago
	
	# Africa & Middle East
	BARBARY_COAST,     # North African coast
	GUINEA_COAST,      # West African coast
	
	# Indian Ocean
	ARABIAN_SEA,       # Western Indian Ocean
	MADAGASCAR,        # Eastern Indian Ocean
	
	# Pacific
	SULU_SEA,          # Philippine waters
	DUTCH_EAST_INDIES  # Indonesian Archipelago
}

# Region instance variables
@export var id: Id
@export var name: String
@export_multiline var description: String
@export var bases: Array[PirateBase.Id]
@export var waters: Array[PirateWater.Id]
@export var nationalities: Array[PirateNationality.Id]
@export_multiline var environment: String
@export_multiline var color: String
@export var color_palette: Array[Color]

func _init(p_id = null, p_name = "", p_description = "", 
		  p_bases: Array[PirateBase.Id] = [], p_waters: Array[PirateWater.Id] = [],
		  p_nationalities: Array[PirateNationality.Id] = [], p_environment = "", 
		  p_color = "", p_color_palette: Array[Color] = []) -> void:
	id = p_id
	name = p_name
	description = p_description
	bases = p_bases
	waters = p_waters
	nationalities = p_nationalities
	environment = p_environment
	color = p_color
	color_palette = p_color_palette

static var CARIBBEAN_SEA := PirateRegion.new(
	Id.CARIBBEAN_SEA,
	"Caribbean Sea",
	"The epicenter of the Golden Age of Piracy, where pirates established their own society and preyed on merchant shipping.",
	[
		PirateBase.Id.PORT_ROYAL,
		PirateBase.Id.TORTUGA,
		PirateBase.Id.NASSAU,
		PirateBase.Id.HAVANA,
		PirateBase.Id.SANTO_DOMINGO
	],
	[
		PirateWater.Id.CARIBBEAN_SEA,
		PirateWater.Id.WINDWARD_PASSAGE,
		PirateWater.Id.MONA_PASSAGE,
		PirateWater.Id.LEEWARD_PASSAGE,
		PirateWater.Id.BAHAMA_CHANNEL
	],
	[
		PirateNationality.Id.ENGLISH,
		PirateNationality.Id.FRENCH,
		PirateNationality.Id.DUTCH,
		PirateNationality.Id.SPANISH
	],
	"""
	Setting: Vibrant tropical archipelago with crystalline waters, white sand beaches, and lush islands
	Time: Year-round warm climate with seasonal hurricanes (June-November) and trade winds
	Lighting: Brilliant Caribbean sun, prismatic water reflections, and dramatic storm formations
	""",
	"""
	Primary colors: Azure waters, coral sand, emerald vegetation
	Color mood: Vivid and tropical
	Color effects: Crystal-clear water caustics, dappled palm shadows, iridescent sea spray
	""",
	[
		Color("1ca4ac"),  # Tropical water blue
		Color("ffd700"),  # Golden sand
		Color("00ff7f"),  # Tropical foliage
		Color("48d1cc"),  # Turquoise water
		Color("98ff98"),  # Palm leaf green
		Color("f4a460")   # Sandy beach
	]
)

static var SPANISH_MAIN := PirateRegion.new(
	Id.SPANISH_MAIN,
	"Spanish Main",
	"The mainland coast of Central and South America, rich with Spanish colonial trade and treasure fleets.",
	[
		PirateBase.Id.MARACAIBO,
		PirateBase.Id.PORTO_BELLO,
		PirateBase.Id.CARTAGENA,
		PirateBase.Id.NOMBRE_DE_DIOS,
		PirateBase.Id.CAMPECHE
	],
	[
		PirateWater.Id.GULF_OF_VENEZUELA,
		PirateWater.Id.BAY_OF_HONDURAS,
		PirateWater.Id.GULF_OF_DARIEN,
		PirateWater.Id.PANAMA_BAY,
		PirateWater.Id.MOSQUITO_COAST
	],
	[
		PirateNationality.Id.SPANISH,
		PirateNationality.Id.ENGLISH,
		PirateNationality.Id.DUTCH,
		PirateNationality.Id.FRENCH
	],
	"""
	Setting: Coastal fortifications, dense jungle coastlines, and deep natural harbors
	Time: Tropical climate with distinct wet and dry seasons
	Lighting: Intense equatorial sun with afternoon thunderstorms and jungle-filtered light
	""",
	"""
	Primary colors: Deep green jungle, colonial gold, Spanish red
	Color mood: Rich and historical
	Color effects: Storm lighting, colonial architecture highlights, jungle shadows
	""",
	[Color("004d00"), Color("daa520"), Color("8b0000"), Color("228b22"), Color("cd853f"), Color("666600")]
)

static var MEDITERRANEAN := PirateRegion.new(
	Id.MEDITERRANEAN,
	"Mediterranean Sea",
	"Ancient waters where pirates have operated since antiquity, spanning the coasts of Southern Europe and North Africa.",
	[
		PirateBase.Id.VALETTA,
		PirateBase.Id.PALERMO,
		PirateBase.Id.TUNIS,
		PirateBase.Id.TRIPOLI,
		PirateBase.Id.ALGIERS
	],
	[
		PirateWater.Id.TYRRHENIAN_SEA,
		PirateWater.Id.AEGEAN_SEA,
		PirateWater.Id.ADRIATIC_SEA,
		PirateWater.Id.IONIAN_SEA,
		PirateWater.Id.BALEARIC_SEA
	],
	[
		PirateNationality.Id.OTTOMAN,
		PirateNationality.Id.BARBARY,
		PirateNationality.Id.GREEK,
		PirateNationality.Id.VENETIAN
	],
	"""
	Setting: Rocky coastlines with ancient harbors, limestone cliffs and olive groves
	Time: Hot summers and mild winters with clear skies and strong winds
	Lighting: Intense Mediterranean sun with stark shadows and brilliant reflections
	""",
	"""
	Primary colors: Deep azure blue waters, white limestone, sun-bleached gold
	Color mood: Warm and crystalline 
	Color effects: Sharp contrast between light and shadow, clear water gradients
	""",
	[Color("0073cf"), Color("ffffff"), Color("d4af37"), Color("7ab7e8"), Color("556b2f"), Color("e8c38d")]
)

static var NORTH_SEA := PirateRegion.new(
	Id.NORTH_SEA,
	"North Sea",
	"Turbulent waters between the British Isles and continental Europe, dominated by privateers and naval powers.",
	[
		PirateBase.Id.DUNKIRK,
		PirateBase.Id.OSTEND,
		PirateBase.Id.DOVER,
		PirateBase.Id.HAMBURG,
		PirateBase.Id.AMSTERDAM
	],
	[
		PirateWater.Id.NORTH_SEA,
		PirateWater.Id.ENGLISH_CHANNEL,
		PirateWater.Id.SKAGERRAK,
		PirateWater.Id.KATTEGAT,
		PirateWater.Id.GERMAN_BIGHT
	],
	[
		PirateNationality.Id.ENGLISH,
		PirateNationality.Id.DUTCH,
		PirateNationality.Id.FRENCH
	],
	"""
	Setting: Stormy seas, rocky coastlines, and numerous islands
	Time: Cool temperate climate with frequent storms and fog
	Lighting: Diffused light through overcast skies, occasional clear days with long twilights
	""",
	"""
	Primary colors: Steely grey waters, misty white, weathered brown
	Color mood: Cool and dramatic
	Color effects: Fog banks, stormy seas, Northern lights
	""",
	[Color("708090"), Color("f0ffff"), Color("8b4513"), Color("2f4f4f"), Color("dcdcdc"), Color("4682b4")]
)

static var SOUTH_CHINA_SEA := PirateRegion.new(
	Id.SOUTH_CHINA_SEA,
	"South China Sea",
	"Domain of powerful pirate confederations and maritime outlaws, spanning the waters between China, Southeast Asia, and the Philippines.",
	[
		PirateBase.Id.MACAU,
		PirateBase.Id.XIAMEN,
		PirateBase.Id.CANTON,
		PirateBase.Id.AMOY,
		PirateBase.Id.CHEK_LAP_KOK
	],
	[
		PirateWater.Id.PEARL_RIVER_DELTA,
		PirateWater.Id.TAIWAN_STRAIT,
		PirateWater.Id.LUZON_STRAIT,
		PirateWater.Id.GULF_OF_TONKIN,
		PirateWater.Id.HAINAN_STRAIT
	],
	[
		PirateNationality.Id.CHINESE,
		PirateNationality.Id.JAPANESE,
		PirateNationality.Id.MALAY,
		PirateNationality.Id.SULU
	],
	"""
	Setting: Mountainous coastlines, river deltas, and scattered island archipelagos
	Time: Monsoon seasons with dense fog and tropical storms
	Lighting: Misty mornings, dramatic storm conditions, and golden sunsets
	""",
	"""
	Primary colors: Imperial red, dynasty gold, ink black
	Color mood: Rich and dramatic
	Color effects: Mist gradients, rain effects, lantern glows
	""",
	[Color("bc002d"), Color("ffd700"), Color("000000"), Color("8b4513"), Color("b87333"), Color("98817b")]
)

static var MALACCA_STRAIT := PirateRegion.new(
	Id.MALACCA_STRAIT,
	"Strait of Malacca",
	"Crucial maritime chokepoint between the Indian and Pacific Oceans, plagued by pirates for centuries.",
	[
		PirateBase.Id.MALACCA_TOWN,
		PirateBase.Id.SINGAPORE,
		PirateBase.Id.PENANG,
		PirateBase.Id.ACEH,
		PirateBase.Id.RIAU
	],
	[
		PirateWater.Id.MALACCA_STRAIT,
		PirateWater.Id.SINGAPORE_STRAIT,
		PirateWater.Id.SUNDA_STRAIT,
		PirateWater.Id.KARIMATA_STRAIT,
		PirateWater.Id.PHILLIPS_CHANNEL
	],
	[
		PirateNationality.Id.MALAY,
		PirateNationality.Id.BUGIS,
		PirateNationality.Id.CHINESE,
		PirateNationality.Id.DUTCH
	],
	"""
	Setting: Narrow sea strait with dense jungle coastlines and numerous small islands
	Time: Tropical climate with high humidity and frequent rainfall
	Lighting: Diffused sunlight through jungle canopy, dramatic tropical storms
	""",
	"""
	Primary colors: Deep jungle green, tropical sea blue, sandy beige
	Color mood: Lush and mysterious
	Color effects: Dappled sunlight, storm-tossed seas
	""",
	[Color("006400"), Color("000080"), Color("f4a460"), Color("2e8b57"), Color("1e90ff"), Color("8b4513")]
)

static var SULU_SEA := PirateRegion.new(
	Id.SULU_SEA,
	"Sulu Sea",
	"Pirate-infested waters between the Philippines, Borneo, and the Celebes Sea.",
	[
		PirateBase.Id.JOLO,
		PirateBase.Id.TAWI_TAWI,
		PirateBase.Id.ZAMBOANGA,
		PirateBase.Id.BASILAN,
		PirateBase.Id.BALANGINGI
	],
	[
		PirateWater.Id.SULU_SEA,
		PirateWater.Id.CELEBES_SEA,
		PirateWater.Id.SIBUTU_PASSAGE,
		PirateWater.Id.MINDORO_STRAIT,
		PirateWater.Id.BALABAC_STRAIT
	],
	[
		PirateNationality.Id.SULU,
		PirateNationality.Id.MALAY,
		PirateNationality.Id.BUGIS
	],
	"""
	Setting: Archipelagic waters with numerous islands, coral reefs, and hidden coves
	Time: Tropical climate with monsoon influences
	Lighting: Bright equatorial sun, dramatic storm conditions, phosphorescent nights
	""",
	"""
	Primary colors: Turquoise sea, coral pink, jungle green
	Color mood: Exotic and dangerous
	Color effects: Coral reflections, tropical storm lighting, bioluminescent waters
	""",
	[Color("40e0d0"), Color("ffb6c1"), Color("228b22"), Color("00ced1"), Color("ff69b4"), Color("2e8b57")]
)

static var ARABIAN_SEA := PirateRegion.new(
	Id.ARABIAN_SEA,
	"Arabian Sea",
	"Vital trade route connecting the Middle East, India, and East Africa, targeted by various pirate groups.",
	[
		PirateBase.Id.RAS_AL_KHAIMAH,
		PirateBase.Id.MUSCAT,
		PirateBase.Id.SURAT,
		PirateBase.Id.HORMUZ,
		PirateBase.Id.SOCOTRA
	],
	[
		PirateWater.Id.PERSIAN_GULF,
		PirateWater.Id.GULF_OF_OMAN,
		PirateWater.Id.GULF_OF_ADEN,
		PirateWater.Id.RED_SEA,
		PirateWater.Id.STRAIT_OF_HORMUZ
	],
	[
		PirateNationality.Id.GUJARATI,
		PirateNationality.Id.MALABAR,
		PirateNationality.Id.PORTUGUESE
	],
	"""
	Setting: Vast open waters with rugged coastlines and strategic island outposts
	Time: Monsoon-driven climate with distinct sailing seasons
	Lighting: Intense sun with clear skies, occasional dust storms, starlit nights
	""",
	"""
	Primary colors: Deep ocean blue, desert sand, spice orange
	Color mood: Exotic and vast
	Color effects: Shimmering heat, dust-laden winds, desert light
	""",
	[Color("000080"), Color("f4a460"), Color("ff8c00"), Color("1e90ff"), Color("cd853f"), Color("8b008b")]
)

static var MADAGASCAR := PirateRegion.new(
	Id.MADAGASCAR,
	"Madagascar",
	"Pirate haven in the Indian Ocean, base for raids on rich East India Company trading ships.",
	[
		PirateBase.Id.ILE_SAINTE_MARIE,
		PirateBase.Id.FORT_DAUPHIN,
		PirateBase.Id.ANTONGIL_BAY,
		PirateBase.Id.DIEGO_SUAREZ,
		PirateBase.Id.NOSY_BORAHA
	],
	[
		PirateWater.Id.MOZAMBIQUE_CHANNEL,
		PirateWater.Id.MASCARENE_BASIN,
		PirateWater.Id.SOMALI_BASIN,
		PirateWater.Id.MADAGASCAR_BASIN,
		PirateWater.Id.AGULHAS_CURRENT
	],
	[
		PirateNationality.Id.ENGLISH,
		PirateNationality.Id.FRENCH,
		PirateNationality.Id.PORTUGUESE
	],
	"""
	Setting: Tropical island with hidden bays, dense jungles, and coral reefs
	Time: Tropical climate with rainy and dry seasons
	Lighting: Bright tropical sun, dramatic storm lighting, luminous reef waters
	""",
	"""
	Primary colors: Lush green, ocean blue, volcanic black
	Color mood: Wild and untamed
	Color effects: Jungle shadows, coral sea reflections, volcanic mists
	""",
	[Color("228b22"), Color("0000cd"), Color("2f4f4f"), Color("32cd32"), Color("00ced1"), Color("8b0000")]
)

static var DUTCH_EAST_INDIES := PirateRegion.new(
	Id.DUTCH_EAST_INDIES,
	"Dutch East Indies",
	"Vast archipelagic region controlled by the Dutch East India Company, y, frequent target of pirates.",
	[
		PirateBase.Id.BATAVIA,
		PirateBase.Id.AMBON,
		PirateBase.Id.BANDA_NEIRA,
		PirateBase.Id.TERNATE,
		PirateBase.Id.MAKASSAR
	],
	[
		PirateWater.Id.JAVA_SEA,
		PirateWater.Id.BANDA_SEA,
		PirateWater.Id.MOLUCCA_SEA,
		PirateWater.Id.FLORES_SEA,
		PirateWater.Id.MAKASSAR_STRAIT
	],
	[
		PirateNationality.Id.DUTCH,
		PirateNationality.Id.BUGIS,
		PirateNationality.Id.MALAY,
		PirateNationality.Id.CHINESE
	],
	"""
	Setting: Volcanic islands, spice plantations, and complex waterways
	Time: Tropical climate with monsoon patterns
	Lighting: Filtered equatorial light, volcanic haze, pearl-like dawns
	""",
	"""
	Primary colors: Spice brown, volcanic grey, colonial white
	Color mood: Rich and colonial
	Color effects: Volcanic mists, tropical storm lighting, spice-trade hues
	""",
	[Color("8b4513"), Color("696969"), Color("f5f5f5"), Color("556b2f"), Color("daa520"), Color("4682b4")]
)

static var GUINEA_COAST := PirateRegion.new(
	Id.GUINEA_COAST,
	"Guinea Coast",
	"West African coastline stretching from Senegal to Nigeria, a hub of slave trade and piracy.",
	[
		PirateBase.Id.CAPE_COAST,
		PirateBase.Id.ELMINA,
		PirateBase.Id.OUIDAH,
		PirateBase.Id.BONNY,
		PirateBase.Id.CALABAR
	],
	[
		PirateWater.Id.GULF_OF_GUINEA,
		PirateWater.Id.BIGHT_OF_BENIN,
		PirateWater.Id.BIGHT_OF_BIAFRA,
		PirateWater.Id.GOLD_COAST,
		PirateWater.Id.SLAVE_COAST
	],
	[
		PirateNationality.Id.ENGLISH,
		PirateNationality.Id.DUTCH,
		PirateNationality.Id.PORTUGUESE
	],
	"""
	Setting: Tropical coastline with mangrove swamps, river deltas, and golden beaches
	Time: Tropical climate with wet and dry seasons
	Lighting: Intense equatorial sun, hazy atmospheres, golden evenings
	""",
	"""
	Primary colors: Jungle green, sand gold, muddy brown
	Color mood: Hot and humid
	Color effects: Heat shimmer, tropical haze, delta mists
	""",
	[Color("006400"), Color("ffd700"), Color("8b4513"), Color("228b22"), Color("d2691e"), Color("556b2f")]
)

# Collection of all pirate regions
static var ALL_REGIONS : Array[PirateRegion] = [
	# Americas
	CARIBBEAN_SEA,      # Caribbean waters
	SPANISH_MAIN,       # South American coast
	
	# Europe
	MEDITERRANEAN,      # Mediterranean Sea
	NORTH_SEA,         # Northern European waters
	
	# East & Southeast Asia
	SOUTH_CHINA_SEA,   # Chinese waters
	MALACCA_STRAIT,    # Malay Archipelago
	
	# Africa & Middle East
	BARBARY_COAST,     # North African coast
	GUINEA_COAST,      # West African coast
	
	# Indian Ocean
	ARABIAN_SEA,       # Western Indian Ocean
	MADAGASCAR,        # Eastern Indian Ocean
	
	# Pacific
	SULU_SEA,          # Philippine waters
	DUTCH_EAST_INDIES  # Indonesian Archipelago
]
