class_name PirateWater
extends Resource

enum Id {
	# Caribbean Waters
	CARIBBEAN_SEA,      # Main Caribbean Basin
	WINDWARD_PASSAGE,   # Between Cuba and Hispaniola
	MONA_PASSAGE,       # Between Hispaniola and Puerto Rico
	LEEWARD_PASSAGE,    # Lesser Antilles
	BAHAMA_CHANNEL,     # Florida Straits
	
	# Spanish Main Waters
	GULF_OF_VENEZUELA,  # Off Venezuelan Coast
	BAY_OF_HONDURAS,    # Central American Coast
	GULF_OF_DARIEN,    # Panama/Colombia Border
	PANAMA_BAY,         # Pacific side of Panama
	MOSQUITO_COAST,     # Nicaragua/Honduras
	
	# Mediterranean Waters
	TYRRHENIAN_SEA,    # West of Italy
	AEGEAN_SEA,        # Between Greece and Turkey
	ADRIATIC_SEA,      # East of Italy
	IONIAN_SEA,        # South of Italy
	BALEARIC_SEA,      # East of Spain
	
	# North Sea Waters
	NORTH_SEA,         # Between Britain and Europe
	ENGLISH_CHANNEL,   # Between England and France
	SKAGERRAK,         # Between Denmark and Norway
	KATTEGAT,          # Between Denmark and Sweden
	GERMAN_BIGHT,      # Southeast North Sea
	
	# South China Sea Waters
	PEARL_RIVER_DELTA, # South China Coast
	TAIWAN_STRAIT,     # Between China and Taiwan
	LUZON_STRAIT,      # North Philippines
	GULF_OF_TONKIN,    # Vietnam Coast
	HAINAN_STRAIT,     # Off Hainan Island
	
	# Malacca Strait Waters
	MALACCA_STRAIT,    # Between Malaya and Sumatra
	SINGAPORE_STRAIT,  # South of Malay Peninsula
	SUNDA_STRAIT,      # Between Java and Sumatra
	KARIMATA_STRAIT,   # West of Borneo
	PHILLIPS_CHANNEL,  # Singapore Area
	
	# Sulu Sea Waters
	SULU_SEA,          # Philippines
	CELEBES_SEA,       # Between Philippines and Sulawesi
	SIBUTU_PASSAGE,    # South Philippines
	MINDORO_STRAIT,    # West Philippines
	BALABAC_STRAIT,    # South Palawan
	
	# Arabian Sea Waters
	PERSIAN_GULF,      # Between Arabia and Persia
	GULF_OF_OMAN,      # Entrance to Persian Gulf
	GULF_OF_ADEN,      # Between Arabia and Africa
	RED_SEA,           # Between Arabia and Egypt
	STRAIT_OF_HORMUZ,  # Entrance to Persian Gulf
	
	# Madagascar Waters
	MOZAMBIQUE_CHANNEL,     # Between Madagascar and Africa
	MASCARENE_BASIN,        # East of Madagascar
	SOMALI_BASIN,           # North of Madagascar
	MADAGASCAR_BASIN,       # Southeast of Madagascar
	AGULHAS_CURRENT,        # South of Madagascar
	
	# East Indies Waters
	JAVA_SEA,          # North of Java
	BANDA_SEA,         # East Indonesia
	MOLUCCA_SEA,       # Northeast Indonesia
	FLORES_SEA,        # Between Sulawesi and Lesser Sundas
	MAKASSAR_STRAIT,   # Between Borneo and Sulawesi
	
	# Guinea Coast Waters
	GULF_OF_GUINEA,    # West African Coast
	BIGHT_OF_BENIN,    # Nigeria to Ghana
	BIGHT_OF_BIAFRA,   # Cameroon to Nigeria
	GOLD_COAST,        # Ghana Waters
	SLAVE_COAST        # Benin to Nigeria
}

# Waters instance variables
@export var id: Id
@export var name: String
@export_multiline var description: String

func _init(p_id = null, p_name = "", p_description = "") -> void:
	id = p_id
	name = p_name
	description = description

# Caribbean Waters
static var CARIBBEAN_SEA := PirateWater.new(
	Id.CARIBBEAN_SEA,
	"Caribbean Sea",
	"""
	Main body of water in the Caribbean region. Central arena of the Golden Age of
	Piracy, connecting major pirate bases and Spanish trade routes.
	"""
)

static var WINDWARD_PASSAGE := PirateWater.new(
	Id.WINDWARD_PASSAGE,
	"Windward Passage",
	"""
	Strategic strait between Cuba and Hispaniola. Major route for ships entering
	the Caribbean from the Atlantic, frequently patrolled by pirates.
	"""
)

static var MONA_PASSAGE := PirateWater.new(
	Id.MONA_PASSAGE,
	"Mona Passage",
	"""
	Channel between Hispaniola and Puerto Rico. Important route for ships traveling
	between Europe and the Spanish Main.
	"""
)

static var LEEWARD_PASSAGE := PirateWater.new(
	Id.LEEWARD_PASSAGE,
	"Leeward Passage",
	"""
	Waters around the Lesser Antilles. Chain of islands providing numerous hiding
	places and ambush points for pirates.
	"""
)

static var BAHAMA_CHANNEL := PirateWater.new(
	Id.BAHAMA_CHANNEL,
	"Bahama Channel",
	"""
	Also known as the Florida Straits. Critical passage for Spanish treasure fleets
	returning to Europe, frequently targeted by pirates.
	"""
)

# Spanish Main Waters
static var GULF_OF_VENEZUELA := PirateWater.new(
	Id.GULF_OF_VENEZUELA,
	"Gulf of Venezuela",
	"""
	Protected waters off the Venezuelan coast. Access point to Lake Maracaibo and
	key hunting ground for pirates targeting Spanish colonial trade.
	"""
)

static var BAY_OF_HONDURAS := PirateWater.new(
	Id.BAY_OF_HONDURAS,
	"Bay of Honduras",
	"""
	Rich trading waters along the Central American coast. Center of logwood trade
	and frequent target for English and Dutch pirates.
	"""
)

static var GULF_OF_DARIEN := PirateWater.new(
	Id.GULF_OF_DARIEN,
	"Gulf of Darien",
	"""
	Strategic waters between Panama and Colombia. Favored staging area for raids
	against Spanish colonial settlements and treasure shipments.
	"""
)

static var PANAMA_BAY := PirateWater.new(
	Id.PANAMA_BAY,
	"Panama Bay",
	"""
	Pacific entrance to the Panama isthmus. Critical waters for Spanish silver
	fleet and target of numerous pirate expeditions.
	"""
)

static var MOSQUITO_COAST := PirateWater.new(
	Id.MOSQUITO_COAST,
	"Mosquito Coast",
	"""
	Waters along Nicaragua and Honduras. Haven for English and Dutch pirates,
	supported by local Miskito allies.
	"""
)

# Mediterranean Waters
static var TYRRHENIAN_SEA := PirateWater.new(
	Id.TYRRHENIAN_SEA,
	"Tyrrhenian Sea",
	"""
	Waters between Italy and its major islands. Contested zone between Christian
	corsairs and Barbary pirates.
	"""
)

static var AEGEAN_SEA := PirateWater.new(
	Id.AEGEAN_SEA,
	"Aegean Sea",
	"""
	Waters between Greece and Turkey. Ancient pirate hunting grounds with countless
	islands providing hiding places and bases.
	"""
)

static var ADRIATIC_SEA := PirateWater.new(
	Id.ADRIATIC_SEA,
	"Adriatic Sea",
	"""
	Waters between Italy and the Balkans. Dominated by Venetian naval power and
	frequented by both Christian and Muslim corsairs.
	"""
)

static var IONIAN_SEA := PirateWater.new(
	Id.IONIAN_SEA,
	"Ionian Sea",
	"""
	Waters west of Greece. Major route for Ottoman and Venetian trade, regularly
	patrolled by corsairs of both sides.
	"""
)

static var BALEARIC_SEA := PirateWater.new(
	Id.BALEARIC_SEA,
	"Balearic Sea",
	"""
	Waters around the Balearic Islands. Strategic area for Barbary corsairs
	raiding Spanish and French shipping.
	"""
)

# North Sea Waters
static var NORTH_SEA := PirateWater.new(
	Id.NORTH_SEA,
	"North Sea",
	"""
	Major waters between Britain and continental Europe. Center of trade and
	privateering during the Anglo-Dutch Wars.
	"""
)

static var ENGLISH_CHANNEL := PirateWater.new(
	Id.ENGLISH_CHANNEL,
	"English Channel",
	"""
	Narrow seas between England and France. Crucial shipping lane and hunting
	ground for privateers of all nations.
	"""
)

static var SKAGERRAK := PirateWater.new(
	Id.SKAGERRAK,
	"Skagerrak",
	"""
	Waters between Denmark and Norway. Strategic entrance to the Baltic Sea and
	vital route for Dutch and English trade.
	"""
)

static var KATTEGAT := PirateWater.new(
	Id.KATTEGAT,
	"Kattegat",
	"""
	Waters between Denmark and Sweden. Key approach to the Baltic Sea and scene
	of frequent naval conflicts.
	"""
)

static var GERMAN_BIGHT := PirateWater.new(
	Id.GERMAN_BIGHT,
	"German Bight",
	"""
	Southeastern portion of the North Sea. Important waters for trade with German
	and Dutch ports, frequently patrolled by privateers.
	"""
)

# South China Sea Waters
static var PEARL_RIVER_DELTA := PirateWater.new(
	Id.PEARL_RIVER_DELTA,
	"Pearl River Delta",
	"""
	Complex waterways around Canton and Macau. Major base area for Chinese pirate
	confederations and scene of numerous naval battles.
	"""
)

static var TAIWAN_STRAIT := PirateWater.new(
	Id.TAIWAN_STRAIT,
	"Taiwan Strait",
	"""
	Waters between China and Taiwan. Strategic corridor for maritime trade and
	key operating area for Chinese and Japanese pirates.
	"""
)

static var LUZON_STRAIT := PirateWater.new(
	Id.LUZON_STRAIT,
	"Luzon Strait",
	"""
	Waters between Taiwan and Philippines. Critical passage for Manila galleons
	and major hunting ground for Chinese pirates.
	"""
)

static var GULF_OF_TONKIN := PirateWater.new(
	Id.GULF_OF_TONKIN,
	"Gulf of Tonkin",
	"""
	Waters between Vietnam and Hainan. Rich fishing grounds and traditional
	operating area for Chinese and Vietnamese pirates.
	"""
)

static var HAINAN_STRAIT := PirateWater.new(
	Id.HAINAN_STRAIT,
	"Hainan Strait",
	"""
	Waters between Hainan Island and mainland China. Sheltered passage frequently
	used by pirates as hiding place and ambush point.
	"""
)

# Malacca Strait Waters
static var MALACCA_STRAIT := PirateWater.new(
	Id.MALACCA_STRAIT,
	"Malacca Strait",
	"""
	Major maritime chokepoint between Malaya and Sumatra. World's busiest shipping
	lane and historic hunting ground for pirates.
	"""
)

static var SINGAPORE_STRAIT := PirateWater.new(
	Id.SINGAPORE_STRAIT,
	"Singapore Strait",
	"""
	Southern entrance to the Malacca Strait. Narrow waters ideal for pirate
	ambushes and critical for regional trade.
	"""
)

static var SUNDA_STRAIT := PirateWater.new(
	Id.SUNDA_STRAIT,
	"Sunda Strait",
	"""
	Waters between Java and Sumatra. Alternative route to the Spice Islands and
	frequent haunt of local pirates.
	"""
)

static var KARIMATA_STRAIT := PirateWater.new(
	Id.KARIMATA_STRAIT,
	"Karimata Strait",
	"""
	Waters between Sumatra and Borneo. Important passage for regional trade and
	operating area for Malay pirates.
	"""
)

static var PHILLIPS_CHANNEL := PirateWater.new(
	Id.PHILLIPS_CHANNEL,
	"Phillips Channel",
	"""
	Narrow waters near Singapore. Critical chokepoint for shipping and favorite
	ambush point for local pirates.
	"""
)

# Sulu Sea Waters
static var SULU_SEA := PirateWater.new(
	Id.SULU_SEA,
	"Sulu Sea",
	"""
	Central waters of the Philippine archipelago. Traditional operating area of
	Moro pirates and scene of numerous raids.
	"""
)

static var CELEBES_SEA := PirateWater.new(
	Id.CELEBES_SEA,
	"Celebes Sea",
	"""
	Waters between Philippines and Sulawesi. Rich trading region and crucial
	operating area for Sulu and Iranun pirates.
	"""
)

static var SIBUTU_PASSAGE := PirateWater.new(
	Id.SIBUTU_PASSAGE,
	"Sibutu Passage",
	"""
	Waters between Sulu and Borneo. Strategic route for regional trade and key
	passage for Sulu raiders.
	"""
)

static var MINDORO_STRAIT := PirateWater.new(
	Id.MINDORO_STRAIT,
	"Mindoro Strait",
	"""
	Waters west of the Philippines. Important shipping lane and traditional
	hunting ground for Moro pirates.
	"""
)

static var BALABAC_STRAIT := PirateWater.new(
	Id.BALABAC_STRAIT,
	"Balabac Strait",
	"""
	Southern approach to the Philippines. Key passage between Sulu and South
	China Seas, frequently used by pirates.
	"""
)

# Arabian Sea Waters
static var PERSIAN_GULF := PirateWater.new(
	Id.PERSIAN_GULF,
	"Persian Gulf",
	"""
	Waters between Arabia and Persia. Historic center of maritime trade and
	operating area for Qawasim raiders.
	"""
)

static var GULF_OF_OMAN := PirateWater.new(
	Id.GULF_OF_OMAN,
	"Gulf of Oman",
	"""
	Approach to the Persian Gulf. Strategic waters connecting Indian Ocean trade
	to the Persian Gulf region.
	"""
)

static var GULF_OF_ADEN := PirateWater.new(
	Id.GULF_OF_ADEN,
	"Gulf of Aden",
	"""
	Waters between Arabia and Horn of Africa. Critical approach to Red Sea and
	historic pirate hunting ground.
	"""
)

static var RED_SEA := PirateWater.new(
	Id.RED_SEA,
	"Red Sea",
	"""
	Waters between Arabia and Africa. Ancient trade route and scene of numerous
	pirate raids throughout history.
	"""
)

static var STRAIT_OF_HORMUZ := PirateWater.new(
	Id.STRAIT_OF_HORMUZ,
	"Strait of Hormuz",
	"""
	Entrance to the Persian Gulf. Strategic chokepoint controlling access to
	Persian Gulf trade routes.
	"""
)

# Madagascar Waters
static var MOZAMBIQUE_CHANNEL := PirateWater.new(
	Id.MOZAMBIQUE_CHANNEL,
	"Mozambique Channel",
	"""
	Waters between Madagascar and African mainland. Major route for East India
	trade and hunting ground for European pirates.
	"""
)

static var MASCARENE_BASIN := PirateWater.new(
	Id.MASCARENE_BASIN,
	"Mascarene Basin",
	"""
	Waters east of Madagascar. Rich hunting grounds near major Indian Ocean
	trade routes.
	"""
)

static var SOMALI_BASIN := PirateWater.new(
	Id.SOMALI_BASIN,
	"Somali Basin",
	"""
	Waters north of Madagascar. Strategic area connecting Red Sea trade to
	Indian Ocean routes.
	"""
)

static var MADAGASCAR_BASIN := PirateWater.new(
	Id.MADAGASCAR_BASIN,
	"Madagascar Basin",
	"""
	Waters southeast of Madagascar. Deep water region along major East India
	Company routes.
	"""
)

static var AGULHAS_CURRENT := PirateWater.new(
	Id.AGULHAS_CURRENT,
	"Agulhas Current",
	"""
	Waters south of Madagascar. Powerful ocean current used by ships trading
	between Europe and Asia.
	"""
)

# East Indies Waters
static var JAVA_SEA := PirateWater.new(
	Id.JAVA_SEA,
	"Java Sea",
	"""
	Waters north of Java. Center of Dutch East Indies trade and frequent
	operating area for local pirates.
	"""
)

static var BANDA_SEA := PirateWater.new(
	Id.BANDA_SEA,
	"Banda Sea",
	"""
	Waters of the central East Indies. Heart of the spice trade and scene
	of numerous conflicts between Europeans and locals.
	"""
)

static var MOLUCCA_SEA := PirateWater.new(
	Id.MOLUCCA_SEA,
	"Molucca Sea",
	"""
	Waters around the Spice Islands. Rich trading region contested between
	European powers and local sultanates.
	"""
)

static var FLORES_SEA := PirateWater.new(
	Id.FLORES_SEA,
	"Flores Sea",
	"""
	Waters between Sulawesi and Lesser Sundas. Important route for regional
	trade and operating area for Bugis raiders.
	"""
)

static var MAKASSAR_STRAIT := PirateWater.new(
	Id.MAKASSAR_STRAIT,
	"Makassar Strait",
	"""
	Waters between Borneo and Sulawesi. Strategic passage for spice trade
	and traditional operating area for Bugis pirates.
	"""
)

# Guinea Coast Waters
static var GULF_OF_GUINEA := PirateWater.new(
	Id.GULF_OF_GUINEA,
	"Gulf of Guinea",
	"""
	Waters off West Africa. Major center of European trading activity and
	scene of numerous pirate raids.
	"""
)

static var BIGHT_OF_BENIN := PirateWater.new(
	Id.BIGHT_OF_BENIN,
	"Bight of Benin",
	"""
	Waters from Nigeria to Ghana. Center of slave trade and operating area
	for European interlopers.
	"""
)

static var BIGHT_OF_BIAFRA := PirateWater.new(
	Id.BIGHT_OF_BIAFRA,
	"Bight of Biafra",
	"""
	Waters from Cameroon to Nigeria. Rich trading region and important center
	of maritime commerce.
	"""
)

static var GOLD_COAST := PirateWater.new(
	Id.GOLD_COAST,
	"Gold Coast",
	"""
	Waters off modern Ghana. Center of gold trade and scene of competition
	between European powers.
	"""
)

static var SLAVE_COAST := PirateWater.new(
	Id.SLAVE_COAST,
	"Slave Coast",
	"""
	Waters from Benin to Nigeria. Major center of slave trade and frequent
	target for pirates and privateers.
	"""
)

# Collection of all waters
static var ALL_WATERS = {
	# Caribbean Waters
	Id.CARIBBEAN_SEA: CARIBBEAN_SEA,
	Id.WINDWARD_PASSAGE: WINDWARD_PASSAGE,
	Id.MONA_PASSAGE: MONA_PASSAGE,
	Id.LEEWARD_PASSAGE: LEEWARD_PASSAGE,
	Id.BAHAMA_CHANNEL: BAHAMA_CHANNEL,
	
	# Spanish Main Waters
	Id.GULF_OF_VENEZUELA: GULF_OF_VENEZUELA,
	Id.BAY_OF_HONDURAS: BAY_OF_HONDURAS,
	Id.GULF_OF_DARIEN: GULF_OF_DARIEN,
	Id.PANAMA_BAY: PANAMA_BAY,
	Id.MOSQUITO_COAST: MOSQUITO_COAST,
	
	# Mediterranean Waters
	Id.TYRRHENIAN_SEA: TYRRHENIAN_SEA,
	Id.AEGEAN_SEA: AEGEAN_SEA,
	Id.ADRIATIC_SEA: ADRIATIC_SEA,
	Id.IONIAN_SEA: IONIAN_SEA,
	Id.BALEARIC_SEA: BALEARIC_SEA,
	
	# North Sea Waters
	Id.NORTH_SEA: NORTH_SEA,
	Id.ENGLISH_CHANNEL: ENGLISH_CHANNEL,
	Id.SKAGERRAK: SKAGERRAK,
	Id.KATTEGAT: KATTEGAT,
	Id.GERMAN_BIGHT: GERMAN_BIGHT,
	
	# South China Sea Waters
	Id.PEARL_RIVER_DELTA: PEARL_RIVER_DELTA,
	Id.TAIWAN_STRAIT: TAIWAN_STRAIT,
	Id.LUZON_STRAIT: LUZON_STRAIT,
	Id.GULF_OF_TONKIN: GULF_OF_TONKIN,
	Id.HAINAN_STRAIT: HAINAN_STRAIT,
	
	# Malacca Strait Waters
	Id.MALACCA_STRAIT: MALACCA_STRAIT,
	Id.SINGAPORE_STRAIT: SINGAPORE_STRAIT,
	Id.SUNDA_STRAIT: SUNDA_STRAIT,
	Id.KARIMATA_STRAIT: KARIMATA_STRAIT,
	Id.PHILLIPS_CHANNEL: PHILLIPS_CHANNEL,
	
	# Sulu Sea Waters
	Id.SULU_SEA: SULU_SEA,
	Id.CELEBES_SEA: CELEBES_SEA,
	Id.SIBUTU_PASSAGE: SIBUTU_PASSAGE,
	Id.MINDORO_STRAIT: MINDORO_STRAIT,
	Id.BALABAC_STRAIT: BALABAC_STRAIT,
	
	# Arabian Sea Waters
	Id.PERSIAN_GULF: PERSIAN_GULF,
	Id.GULF_OF_OMAN: GULF_OF_OMAN,
	Id.GULF_OF_ADEN: GULF_OF_ADEN,
	Id.RED_SEA: RED_SEA,
	Id.STRAIT_OF_HORMUZ: STRAIT_OF_HORMUZ,
	
	# Madagascar Waters
	Id.MOZAMBIQUE_CHANNEL: MOZAMBIQUE_CHANNEL,
	Id.MASCARENE_BASIN: MASCARENE_BASIN,
	Id.SOMALI_BASIN: SOMALI_BASIN,
	Id.MADAGASCAR_BASIN: MADAGASCAR_BASIN,
	Id.AGULHAS_CURRENT: AGULHAS_CURRENT,
	
	# East Indies Waters
	Id.JAVA_SEA: JAVA_SEA,
	Id.BANDA_SEA: BANDA_SEA,
	Id.MOLUCCA_SEA: MOLUCCA_SEA,
	Id.FLORES_SEA: FLORES_SEA,
	Id.MAKASSAR_STRAIT: MAKASSAR_STRAIT,
	
	# Guinea Coast Waters
	Id.GULF_OF_GUINEA: GULF_OF_GUINEA,
	Id.BIGHT_OF_BENIN: BIGHT_OF_BENIN,
	Id.BIGHT_OF_BIAFRA: BIGHT_OF_BIAFRA,
	Id.GOLD_COAST: GOLD_COAST,
	Id.SLAVE_COAST: SLAVE_COAST
}
