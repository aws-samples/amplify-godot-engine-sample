extends Resource
class_name PirateBase

enum Id {
	# Caribbean Bases
	PORT_ROYAL,         # Jamaica
	TORTUGA,           # Haiti
	NASSAU,            # Bahamas
	HAVANA,            # Cuba
	SANTO_DOMINGO,     # Hispaniola
	
	# Spanish Main Bases
	MARACAIBO,         # Venezuela
	PORTO_BELLO,       # Panama
	CARTAGENA,         # Colombia
	NOMBRE_DE_DIOS,    # Panama
	CAMPECHE,          # Mexico
	
	# Mediterranean Bases
	VALETTA,           # Malta
	PALERMO,           # Sicily
	TUNIS,             # Tunisia
	TRIPOLI,           # Libya
	ALGIERS,           # Algeria
	
	# North Sea Bases
	DUNKIRK,           # French Flanders
	OSTEND,            # Flanders
	DOVER,             # England
	HAMBURG,           # Germany
	AMSTERDAM,         # Netherlands
	
	# South China Sea Bases
	MACAU,             # Pearl River Delta
	XIAMEN,            # Fujian
	CANTON,            # Guangdong
	AMOY,              # Fujian
	CHEK_LAP_KOK,      # Hong Kong
	
	# Malacca Strait Bases
	MALACCA_TOWN,      # Malaya
	SINGAPORE,         # Straits Settlements
	PENANG,            # Malaya
	ACEH,              # Sumatra
	RIAU,              # Indonesia
	
	# Sulu Sea Bases
	JOLO,              # Sulu Archipelago
	TAWI_TAWI,         # Sulu Archipelago
	ZAMBOANGA,         # Mindanao
	BASILAN,           # Sulu Archipelago
	BALANGINGI,        # Sulu Archipelago
	
	# Arabian Sea Bases
	RAS_AL_KHAIMAH,    # UAE
	MUSCAT,            # Oman
	SURAT,             # Gujarat
	HORMUZ,            # Strait of Hormuz
	SOCOTRA,           # Yemen
	
	# Madagascar Bases
	ILE_SAINTE_MARIE,  # Madagascar
	FORT_DAUPHIN,      # Madagascar
	ANTONGIL_BAY,      # Madagascar
	DIEGO_SUAREZ,      # Madagascar
	NOSY_BORAHA,       # Madagascar
	
	# East Indies Bases
	BATAVIA,           # Java
	AMBON,             # Maluku Islands
	BANDA_NEIRA,       # Banda Islands
	TERNATE,           # Maluku Islands
	MAKASSAR,          # Sulawesi
	
	# Guinea Coast Bases
	CAPE_COAST,        # Ghana
	ELMINA,            # Ghana
	OUIDAH,            # Benin
	BONNY,             # Nigeria
	CALABAR            # Nigeria
}

# Base instance variables
@export var id: Id
@export var name: String
@export_multiline var description: String

func _init(p_id = null, p_name = "", p_description = "") -> void:
	id = p_id
	name = p_name
	description = description

# Caribbean Bases
static var PORT_ROYAL := PirateBase.new(
	Id.PORT_ROYAL,
	"Port Royal",
	"""
	Known as the 'Wickedest City on Earth', Port Royal was the unofficial capital of
	Jamaica's pirates and buccaneers. The base served as a convenient point for raids
	on Spanish commerce until its destruction by earthquake in 1692.
	"""
)

static var TORTUGA := PirateBase.new(
	Id.TORTUGA,
	"Tortuga",
	"""
	Notorious pirate haven off the northern coast of Haiti. Served as the major
	base for the Brethren of the Coast and became a center for French and English
	buccaneers attacking Spanish shipping.
	"""
)

static var NASSAU := PirateBase.new(
	Id.NASSAU,
	"Nassau",
	"""
	Capital of the 'Pirate Republic' during the Golden Age of Piracy. The shallow
	harbor made it difficult for large warships to approach, while providing perfect
	shelter for pirate vessels.
	"""
)

static var HAVANA := PirateBase.new(
	Id.HAVANA,
	"Havana",
	"""
	Major Spanish stronghold that alternated between being a target for pirates and
	a base for Spanish privateers. Its strategic location made it crucial for controlling
	access to the Gulf of Mexico.
	"""
)

static var SANTO_DOMINGO := PirateBase.new(
	Id.SANTO_DOMINGO,
	"Santo Domingo",
	"""
	Oldest European settlement in the Americas, serving both as a target for pirates
	and occasionally as a base for Spanish privateers countering other pirate activities.
	"""
)

# Spanish Main Bases
static var MARACAIBO := PirateBase.new(
	Id.MARACAIBO,
	"Maracaibo",
	"""
	Strategic Venezuelan port city that was repeatedly raided by pirates. Its lagoon
	provided excellent shelter and the narrow entrance could be defended against
	pursuing vessels.
	"""
)

static var PORTO_BELLO := PirateBase.new(
	Id.PORTO_BELLO,
	"Porto Bello",
	"""
	Major Spanish silver-shipping port in Panama. Its rich cargo made it a frequent
	target for pirates and privateers, including Morgan's famous raid of 1668.
	"""
)

static var CARTAGENA := PirateBase.new(
	Id.CARTAGENA,
	"Cartagena",
	"""
	Principal Spanish stronghold in South America. Despite its strong fortifications,
	it was successfully raided by pirates several times, most notably by Francis Drake.
	"""
)

static var NOMBRE_DE_DIOS := PirateBase.new(
	Id.NOMBRE_DE_DIOS,
	"Nombre de Dios",
	"""
	Spanish treasure port in Panama. Terminal of the Spanish treasure trail before
	Porto Bello replaced it. Famous for Drake's raid of 1573.
	"""
)

static var CAMPECHE := PirateBase.new(
	Id.CAMPECHE,
	"Campeche",
	"""
	Mexican port city frequently raided by pirates. Center of logwood cutting trade
	and target for both pirates and privateers throughout the 17th century.
	"""
)

# Mediterranean Bases
static var VALETTA := PirateBase.new(
	Id.VALETTA,
	"Valetta",
	"""
	Headquarters of the Knights of Malta, who engaged in sanctioned raids against
	Ottoman and Muslim shipping. One of the strongest fortified ports in the Mediterranean.
	"""
)

static var PALERMO := PirateBase.new(
	Id.PALERMO,
	"Palermo",
	"""
	Sicilian port that served as a base for Christian corsairs. Strategic location
	for controlling central Mediterranean shipping lanes.
	"""
)

static var TUNIS := PirateBase.new(
	Id.TUNIS,
	"Tunis",
	"""
	Major Barbary corsair port. Home port for many notorious raiders and center of
	Mediterranean slave trade.
	"""
)

static var TRIPOLI := PirateBase.new(
	Id.TRIPOLI,
	"Tripoli",
	"""
	Powerful Barbary corsair state. Base for raids throughout the Mediterranean and
	target of multiple European punitive expeditions.
	"""
)

static var ALGIERS := PirateBase.new(
	Id.ALGIERS,
	"Algiers",
	"""
	Most powerful of the Barbary corsair ports. Center of Mediterranean piracy for
	centuries and home to infamous raiders like Barbarossa.
	"""
)

# North Sea Bases
static var DUNKIRK := PirateBase.new(
	Id.DUNKIRK,
	"Dunkirk",
	"""
	Famous privateer base on the French coast. Home port of the notorious Dunkirkers
	who preyed on Dutch and English shipping.
	"""
)

static var OSTEND := PirateBase.new(
	Id.OSTEND,
	"Ostend",
	"""
	Flemish privateering port that competed with Dunkirk. Base for raids against
	Dutch commerce during the Dutch Revolt.
	"""
)

static var DOVER := PirateBase.new(
	Id.DOVER,
	"Dover",
	"""
	English Channel port crucial for controlling narrow seas. Base for English
	privateers operating against European shipping.
	"""
)

static var HAMBURG := PirateBase.new(
	Id.HAMBURG,
	"Hamburg",
	"""
	Major Hanseatic port that occasionally served as a base for pirates operating
	in the North Sea. Important market for seized goods.
	"""
)

static var AMSTERDAM := PirateBase.new(
	Id.AMSTERDAM,
	"Amsterdam",
	"""
	Center of Dutch maritime power. Home port for Dutch privateers and sea beggars
	during the Dutch Revolt against Spain.
	"""
)

# South China Sea Bases
static var MACAU := PirateBase.new(
	Id.MACAU,
	"Macau",
	"""
	Portuguese settlement that served as both target and occasional refuge for
	Chinese pirates. Important trading center in South China Sea.
	"""
)

static var XIAMEN := PirateBase.new(
	Id.XIAMEN,
	"Xiamen",
	"""
	Major Chinese pirate port. Base for powerful pirate confederations and center
	of maritime resistance to Qing rule.
	"""
)

static var CANTON := PirateBase.new(
	Id.CANTON,
	"Canton",
	"""
	Principal trading port of South China. Both target and occasional base for
	pirate fleets, especially during the late Ming period.
	"""
)

static var AMOY := PirateBase.new(
	Id.AMOY,
	"Amoy",
	"""
	Strategic port controlled by Zheng Chenggong (Koxinga). Major base for
	anti-Qing maritime forces in the 17th century.
	"""
)

static var CHEK_LAP_KOK := PirateBase.new(
	Id.CHEK_LAP_KOK,
	"Chek Lap Kok",
	"""
	Island base near Hong Kong. Haven for Chinese pirates operating in the
	Pearl River Delta region.
	"""
)

# Malacca Strait Bases
static var MALACCA_TOWN := PirateBase.new(
	Id.MALACCA_TOWN,
	"Malacca Town",
	"""
	Strategic port controlling the Strait of Malacca. Alternated between being
	pirate haven and base for anti-piracy operations.
	"""
)

static var SINGAPORE := PirateBase.new(
	Id.SINGAPORE,
	"Singapore",
	"""
	Key maritime settlement at the southern end of the Malacca Strait. Important
	base for controlling regional maritime traffic.
	"""
)

static var PENANG := PirateBase.new(
	Id.PENANG,
	"Penang",
	"""
	British settlement that served as both trading port and occasional pirate haven.
	Important base for controlling northern Malacca Strait.
	"""
)

static var ACEH := PirateBase.new(
	Id.ACEH,
	"Aceh",
	"""
	Powerful sultanate controlling northern tip of Sumatra. Base for raiders
	operating in the Malacca Strait and Indian Ocean.
	"""
)

static var RIAU := PirateBase.new(
	Id.RIAU,
	"Riau",
	"""
	Island base of Malay pirates. Strategic location for controlling southern
	entrance to Malacca Strait.
	"""
)

# Sulu Sea Bases
static var JOLO := PirateBase.new(
	Id.JOLO,
	"Jolo",
	"""
	Capital of the Sulu Sultanate and principal base for Moro pirates. Center
	of maritime raiding in the Sulu Sea region.
	"""
)

static var TAWI_TAWI := PirateBase.new(
	Id.TAWI_TAWI,
	"Tawi-Tawi",
	"""
	Island chain serving as haven for Sulu pirates. Perfect base for raids into
	the Celebes Sea and Borneo waters.
	"""
)

static var ZAMBOANGA := PirateBase.new(
	Id.ZAMBOANGA,
	"Zamboanga",
	"""
	Strategic port on Mindanao. Alternated between being Spanish stronghold and
	Moro pirate base.
	"""
)

static var BASILAN := PirateBase.new(
	Id.BASILAN,
	"Basilan",
	"""
	Island stronghold of Moro pirates. Key base for controlling access to the
	Sulu Sea from the west.
	"""
)

static var BALANGINGI := PirateBase.new(
	Id.BALANGINGI,
	"Balangingi",
	"""
	Notorious base of the Samal pirates. Famous for long-distance slave-taking
	raids throughout Southeast Asian waters.
	"""
)

# Arabian Sea Bases
static var RAS_AL_KHAIMAH := PirateBase.new(
	Id.RAS_AL_KHAIMAH,
	"Ras Al Khaimah",
	"""
	Principal port of the Qawasim maritime confederation. Major base for raids
	against Indian Ocean and Persian Gulf shipping.
	"""
)

static var MUSCAT := PirateBase.new(
	Id.MUSCAT,
	"Muscat",
	"""
	Principal port of Oman. Base for raids into the Indian Ocean and strategic
	point for controlling entrance to Persian Gulf.
	"""
)

static var SURAT := PirateBase.new(
	Id.SURAT,
	"Surat",
	"""
	Major Indian Ocean port and base for Gujarati maritime forces. Target of
	both European and Asian pirates.
	"""
)

static var HORMUZ := PirateBase.new(
	Id.HORMUZ,
	"Hormuz",
	"""
	Strategic island controlling entrance to Persian Gulf. Major base for both
	legitimate trade and piracy.
	"""
)

static var SOCOTRA := PirateBase.new(
	Id.SOCOTRA,
	"Socotra",
	"""
	Strategic island base off Horn of Africa. Used by pirates to intercept
	shipping between Red Sea and Indian Ocean.
	"""
)

# Madagascar Bases
static var ILE_SAINTE_MARIE := PirateBase.new(
	Id.ILE_SAINTE_MARIE,
	"Île Sainte-Marie",
	"""
	Famous pirate settlement off Madagascar's east coast. Major base during the
	Golden Age of Piracy, home to numerous American and European pirates.
	"""
)

static var FORT_DAUPHIN := PirateBase.new(
	Id.FORT_DAUPHIN,
	"Fort Dauphin",
	"""
	French settlement on Madagascar's southeast coast. Served as occasional
	pirate base and trading post.
	"""
)

static var ANTONGIL_BAY := PirateBase.new(
	Id.ANTONGIL_BAY,
	"Antongil Bay",
	"""
	Large natural harbor on Madagascar's northeast coast. Popular haven for
	pirates operating in the Indian Ocean.
	"""
)

static var DIEGO_SUAREZ := PirateBase.new(
	Id.DIEGO_SUAREZ,
	"Diego Suarez",
	"""
	Deep natural harbor in northern Madagascar. Strategic base for pirates
	operating in the Indian Ocean trade routes.
	"""
)

static var NOSY_BORAHA := PirateBase.new(
	Id.NOSY_BORAHA,
	"Nosy Boraha",
	"""
	Alternative name for Île Sainte-Marie. Major pirate settlement with its own
	informal pirate government.
	"""
)

# East Indies Bases
static var BATAVIA := PirateBase.new(
	Id.BATAVIA,
	"Batavia",
	"""
	Dutch East India Company headquarters in Asia. Center for controlling
	maritime trade and suppressing piracy in Indonesian waters.
	"""
)

static var AMBON := PirateBase.new(
	Id.AMBON,
	"Ambon",
	"""
	Key spice island and Dutch stronghold. Strategic base for controlling
	the spice trade routes.
	"""
)

static var BANDA_NEIRA := PirateBase.new(
	Id.BANDA_NEIRA,
	"Banda Neira",
	"""
	Center of nutmeg trade in the Banda Islands. Frequently visited by both
	legitimate traders and pirates.
	"""
)

static var TERNATE := PirateBase.new(
	Id.TERNATE,
	"Ternate",
	"""
	Spice sultanate and trading center. Important base for controlling northern
	Moluccan waters.
	"""
)

static var MAKASSAR := PirateBase.new(
	Id.MAKASSAR,
	"Makassar",
	"""
	Major port in South Sulawesi. Base for Bugis sailors and raiders operating
	throughout Indonesian waters.
	"""
)

# Guinea Coast Bases
static var CAPE_COAST := PirateBase.new(
	Id.CAPE_COAST,
	"Cape Coast",
	"""
	Major European trading fort on the Gold Coast. Important base for both
	legitimate trade and piracy.
	"""
)

static var ELMINA := PirateBase.new(
	Id.ELMINA,
	"Elmina",
	"""
	Oldest European settlement in West Africa. Strategic base for controlling
	Gold Coast maritime trade.
	"""
)

static var OUIDAH := PirateBase.new(
	Id.OUIDAH,
	"Ouidah",
	"""
	Important port on the Slave Coast. Base for both legitimate traders and
	pirates involved in Atlantic trade.
	"""
)

static var BONNY := PirateBase.new(
	Id.BONNY,
	"Bonny",
	"""
	Major port in the Niger Delta. Important base for both traditional African
	maritime powers and European traders.
	"""
)

static var CALABAR := PirateBase.new(
	Id.CALABAR,
	"Calabar",
	"""
	Trading port in the Niger Delta region. Strategic base for controlling
	access to interior waterways.
	"""
)

# Collection of all bases
static var ALL_BASES = {
	# Caribbean Bases
	Id.PORT_ROYAL: PORT_ROYAL,
	Id.TORTUGA: TORTUGA,
	Id.NASSAU: NASSAU,
	Id.HAVANA: HAVANA,
	Id.SANTO_DOMINGO: SANTO_DOMINGO,
	
	# Spanish Main Bases
	Id.MARACAIBO: MARACAIBO,
	Id.PORTO_BELLO: PORTO_BELLO,
	Id.CARTAGENA: CARTAGENA,
	Id.NOMBRE_DE_DIOS: NOMBRE_DE_DIOS,
	Id.CAMPECHE: CAMPECHE,
	
	# Mediterranean Bases
	Id.VALETTA: VALETTA,
	Id.PALERMO: PALERMO,
	Id.TUNIS: TUNIS,
	Id.TRIPOLI: TRIPOLI,
	Id.ALGIERS: ALGIERS,
	
	# North Sea Bases
	Id.DUNKIRK: DUNKIRK,
	Id.OSTEND: OSTEND,
	Id.DOVER: DOVER,
	Id.HAMBURG: HAMBURG,
	Id.AMSTERDAM: AMSTERDAM,
	
	# South China Sea Bases
	Id.MACAU: MACAU,
	Id.XIAMEN: XIAMEN,
	Id.CANTON: CANTON,
	Id.AMOY: AMOY,
	Id.CHEK_LAP_KOK: CHEK_LAP_KOK,
	
	# Malacca Strait Bases
	Id.MALACCA_TOWN: MALACCA_TOWN,
	Id.SINGAPORE: SINGAPORE,
	Id.PENANG: PENANG,
	Id.ACEH: ACEH,
	Id.RIAU: RIAU,
	
	# Sulu Sea Bases
	Id.JOLO: JOLO,
	Id.TAWI_TAWI: TAWI_TAWI,
	Id.ZAMBOANGA: ZAMBOANGA,
	Id.BASILAN: BASILAN,
	Id.BALANGINGI: BALANGINGI,
	
	# Arabian Sea Bases
	Id.RAS_AL_KHAIMAH: RAS_AL_KHAIMAH,
	Id.MUSCAT: MUSCAT,
	Id.SURAT: SURAT,
	Id.HORMUZ: HORMUZ,
	Id.SOCOTRA: SOCOTRA,
	
	# Madagascar Bases
	Id.ILE_SAINTE_MARIE: ILE_SAINTE_MARIE,
	Id.FORT_DAUPHIN: FORT_DAUPHIN,
	Id.ANTONGIL_BAY: ANTONGIL_BAY,
	Id.DIEGO_SUAREZ: DIEGO_SUAREZ,
	Id.NOSY_BORAHA: NOSY_BORAHA,
	
	# East Indies Bases
	Id.BATAVIA: BATAVIA,
	Id.AMBON: AMBON,
	Id.BANDA_NEIRA: BANDA_NEIRA,
	Id.TERNATE: TERNATE,
	Id.MAKASSAR: MAKASSAR,
	
	# Guinea Coast Bases
	Id.CAPE_COAST: CAPE_COAST,
	Id.ELMINA: ELMINA,
	Id.OUIDAH: OUIDAH,
	Id.BONNY: BONNY,
	Id.CALABAR: CALABAR
}
