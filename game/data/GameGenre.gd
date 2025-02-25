extends Resource
class_name GameGenre

enum Id {
	ARPG,
	BATTLE_ROYALE,
	CARD_GAME,
	CITY_BUILDER,
	FIGHTING,
	FPS,
	HORROR,
	LIFE_SIM,
	MOBA,
	OPEN_WORLD,
	PARTY_GAME,
	PLATFORM,
	PUZZLE,
	RACING,
	RHYTHM,
	RPG,
	SPORTS,
	STRATEGY,
	SURVIVAL,
	VISUAL_NOVEL
}

# Instance variables
@export var id: Id
@export var display_name: String
@export var description: String
@export var notable_games: Array[String]
@export var icon_subject: String
@export var image_subjects: Array[String]
@export var video_subjects: Array[String]
@export var icon_paths: Array[String]
@export var image_paths: Array[String]
@export var video_paths: Array[String]

func _init(p_id: Id = Id.RPG,
		p_display_name: String = "",
		p_description: String = "",
		p_notable_games: Array[String] = [],
		p_icon_subject: String = "",
		p_image_subjects: Array[String] = [],
		p_video_subjects: Array[String] = [],
		p_icon_paths: Array[String] = [],
		p_image_paths: Array[String] = [],
		p_video_paths: Array[String] = []) -> void:

	id = p_id
	display_name = p_display_name
	description = p_description
	notable_games = p_notable_games
	icon_subject = p_icon_subject
	image_subjects = p_image_subjects
	video_subjects = p_video_subjects
	icon_paths = p_icon_paths
	image_paths = image_paths
	video_paths = p_video_paths

const BASE_PATH := "res://assets/genres/"

static var ARPG := GameGenre.new(
	Id.ARPG,
	"ARPG",
	"Fast-paced action RPGs focusing on real-time combat and character progression...",
	["Diablo IV", "Path of Exile", "Lost Ark", "Grim Dawn", "Last Epoch"],
	# Icon subject - App store icon
	"Glowing cutlass crossed with shark tooth, optimized for store visibility",
	# Image subjects - Marketing Materials
	[
		"Feature art: Pirate hero unleashing combo chain against shark swarm, highlighting action RPG combat",
		"Loot system showcase: Legendary shark-tooth weapons and oceanic armor sets, for item marketing",
		"Class reveal art: Multiple pirate specializations displaying unique shark-hunting abilities"
	],
	# Video subjects - Commercial Trailers
	[
		"Gameplay trailer: Fast-paced combat featuring spectacular ability effects and loot explosions",
		"Systems trailer: Deep dive into character progression and customization options",
		"Multiplayer showcase: Four-player crew taking down legendary shark boss"
	]
)

static var BATTLE_ROYALE := GameGenre.new(
	Id.BATTLE_ROYALE,
	"Battle Royale",
	"Competitive multiplayer games where players battle to be the last survivor...",
	["Fortnite", "PUBG: Battlegrounds", "Apex Legends", "Call of Duty: Warzone", "Fall Guys"],
	# Icon subject - Platform store icon
	"Victory crown with shark fin emblem, optimized for store visibility",
	# Image subjects - Marketing Materials
	[
		"Key art: Aerial view of massive naval battle with shark hazards, for store features",
		"Season art: New ship types and shark enemies reveal, for marketing campaign",
		"Battle pass promo: Unlockable pirate captains and ship customizations"
	],
	# Video subjects - Commercial Trailers
	[
		"Launch trailer: Epic battle royale action with ships and sharks",
		"Season trailer: New map features and gameplay mechanics reveal",
		"Battle pass trailer: Premium rewards and exclusive content showcase"
	]
)

static var CARD_GAME := GameGenre.new(
	Id.CARD_GAME,
	"Card Game",
	"Strategic games based on collecting and playing cards...",
	["Hearthstone", "Magic: The Gathering Arena", "Slay the Spire", "Marvel Snap", "Legends of Runeterra"],
	# Icon subject - App icon
	"Premium card design featuring pirate and shark duel, optimized for stores",
	# Image subjects - Marketing Materials
	[
		"Card set reveal: New pirate captains and legendary shark cards, for expansion marketing",
		"Gameplay showcase: Strategic card battle with premium visual effects",
		"Collection display: Rare and mythic cards with animated art"
	],
	# Video subjects - Commercial Trailers
	[
		"Expansion trailer: New card set features and mechanics reveal",
		"Gameplay trailer: Strategic depth and spectacular card effects",
		"Battle pass trailer: Exclusive card backs and premium animations"
	]
)

static var CITY_BUILDER := GameGenre.new(
	Id.CITY_BUILDER,
	"City Builder",
	"Management simulation games focusing on building and maintaining urban environments...",
	["Cities: Skylines II", "SimCity", "Frostpunk", "Anno 1800", "Tropico 6"],
	# Icon subject - Store icon
	"Stylized pirate port icon with shark warning flags, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Feature art: Thriving pirate haven with advanced shark defenses, for store listing",
		"Development showcase: Port evolution from small dock to mighty fortress",
		"Management screen: Complex harbor systems and shark monitoring"
	],
	# Video subjects - Commercial Trailers
	[
		"Feature trailer: Port building mechanics and shark defense systems",
		"Management trailer: Deep dive into port simulation systems",
		"Expansion trailer: New buildings and shark interaction features"
	]
)

static var FIGHTING := GameGenre.new(
	Id.FIGHTING,
	"Fighting",
	"Competitive combat games focusing on one-on-one or small team battles...",
	["Street Fighter 6", "Mortal Kombat 1", "Tekken 8", "Guilty Gear Strive", "Super Smash Bros. Ultimate"],
	# Icon subject - Store icon
	"Dynamic versus screen with pirate and shark silhouettes, platform-optimized",
	# Image subjects - Marketing Materials
	[
		"Character roster art: Diverse pirate fighters and shark opponents, for promotional use",
		"Combat showcase: Spectacular special moves and combo systems",
		"Tournament art: Professional competition setup with crowd"
	],
	# Video subjects - Commercial Trailers
	[
		"Character reveal trailer: New fighter movesets and special abilities",
		"Tournament trailer: Competitive scene and esports potential",
		"Season pass trailer: Upcoming fighters and arenas"
	]
)

static var FPS := GameGenre.new(
	Id.FPS,
	"FPS",
	"First-person perspective action games focusing on weapon-based combat...",
	["Counter-Strike 2", "Call of Duty: Modern Warfare", "Doom Eternal", "Overwatch 2", "Valorant"],
	# Icon subject - Store icon
	"First-person harpoon gun with glowing sights, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Weapons showcase: Arsenal of anti-shark weapons with special effects, for store page",
		"Multiplayer action: Team-based combat on pirate ships, for promotional materials",
		"Map reveal: New battle arena with underwater segments, for marketing campaign"
	],
	# Video subjects - Commercial Trailers
	[
		"Gameplay reveal: High-octane FPS action with shark encounters",
		"Multiplayer trailer: 5v5 team combat with objective-based missions",
		"Season content: New weapons, maps, and shark types reveal"
	]
)

static var HORROR := GameGenre.new(
	Id.HORROR,
	"Horror",
	"Games designed to create fear and tension through atmospheric storytelling...",
	["Resident Evil 4", "Dead Space", "Amnesia: The Bunker", "Outlast", "Alien: Isolation"],
	# Icon subject - Store icon
	"Menacing shark shadow behind shattered porthole, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Atmospheric key art: Lone pirate in dark ship corridor with shark silhouette",
		"Tension moment: Underwater escape scene with massive shark shadow",
		"Horror reveal: Discovery of mutant shark-pirate hybrid, for marketing"
	],
	# Video subjects - Commercial Trailers
	[
		"Announcement trailer: Building tension with shark horror reveals",
		"Gameplay trailer: Survival horror mechanics in naval setting",
		"Story trailer: Dark narrative with psychological horror elements"
	]
)

static var LIFE_SIM := GameGenre.new(
	Id.LIFE_SIM,
	"Life Sim",
	"Games simulating daily life, relationships, and personal development...",
	["Animal Crossing: New Horizons", "Stardew Valley", "The Sims 4", "Story of Seasons", "My Time at Portia"],
	# Icon subject - Store icon
	"Cheerful pirate character with friendly shark pet, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Community showcase: Vibrant pirate village life with trained sharks",
		"Activities spread: Fishing, trading, and shark training features",
		"Social feature art: Relationship building with villagers and sea life"
	],
	# Video subjects - Commercial Trailers
	[
		"Feature trailer: Daily life in pirate paradise with shark friends",
		"Seasonal update: New activities and community events",
		"Customization trailer: Home decoration and character styling"
	]
)

static var MOBA := GameGenre.new(
	Id.MOBA,
	"MOBA",
	"Team-based competitive games where players control unique heroes...",
	["League of Legends", "Dota 2", "Heroes of the Storm", "Smite", "Mobile Legends: Bang Bang"],
	# Icon subject - Store icon
	"Hero pirate portrait with competitive emblems, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Hero roster art: Diverse pirate champions and shark opponents",
		"Map overview: Strategic lanes with shark-infested waters",
		"Esports promo: Professional team clash with spectator views"
	],
	# Video subjects - Commercial Trailers
	[
		"Champion spotlight: New hero abilities and gameplay mechanics",
		"Tournament trailer: Competitive matches and epic moments",
		"Season cinematic: Story-driven promotional animation"
	]
)

static var OPEN_WORLD := GameGenre.new(
	Id.OPEN_WORLD,
	"Open World",
	"Expansive, freely explorable game worlds offering non-linear gameplay...",
	["The Legend of Zelda: Breath of the Wild", "Red Dead Redemption 2", "Grand Theft Auto V", "Cyberpunk 2077", "Assassin's Creed Valhalla"],
	# Icon subject - Store icon
	"Stylized compass with shark territories marked, store-optimized",
	# Image subjects - Marketing Materials
	[
		"World map reveal: Vast ocean realm with diverse regions and activities",
		"Feature spread: Multiple activities from shark hunting to exploration",
		"Discovery showcase: Hidden locations and legendary shark lairs"
	],
	# Video subjects - Commercial Trailers
	[
		"World premiere: Vast open seas and underwater exploration",
		"Activities trailer: Diverse gameplay features and side quests",
		"Environmental showcase: Dynamic weather and shark ecosystems"
	]
)

static var PARTY_GAME := GameGenre.new(
	Id.PARTY_GAME,
	"Party Game",
	"Multiplayer-focused games designed for social gatherings...",
	["Mario Party Superstars", "Jackbox Party Pack", "Overcooked! 2", "Among Us", "Ultimate Chicken Horse"],
	# Icon subject - Store icon
	"Colorful dice with pirate and shark symbols, family-friendly store icon",
	# Image subjects - Marketing Materials
	[
		"Minigame showcase: Four-player shark-dodging competition, for family marketing",
		"Party mode spread: Multiple fun activities and board game views",
		"Multiplayer promo: Split-screen chaos with family-friendly action"
	],
	# Video subjects - Commercial Trailers
	[
		"Party trailer: Fast-paced montage of family fun minigames",
		"Multiplayer trailer: Cooperative and competitive party modes",
		"Content update: New minigames and party boards reveal"
	]
)

static var PLATFORM := GameGenre.new(
	Id.PLATFORM,
	"Platform",
	"Games focused on precision movement and obstacle navigation...",
	["Super Mario Bros. Wonder", "Hollow Knight", "Celeste", "Ori and the Will of the Wisps", "Rayman Legends"],
	# Icon subject - Store icon
	"Dynamic pirate mid-jump over shark fin, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Level design showcase: Beautiful side-scrolling seascapes with platforms",
		"Action spread: Perfect timing jumps over shark obstacles",
		"Boss battle art: Epic confrontation with mega-shark boss"
	],
	# Video subjects - Commercial Trailers
	[
		"Gameplay trailer: Fluid platforming and acrobatic movements",
		"Skills showcase: Advanced movement mechanics and combinations",
		"Level reveal: New worlds and challenging sequences"
	]
)

static var PUZZLE := GameGenre.new(
	Id.PUZZLE,
	"Puzzle",
	"Games focused on logical problem-solving and pattern recognition...",
	["Portal", "The Witness", "Baba Is You", "Tetris Effect", "Return of the Obra Dinn"],
	# Icon subject - Store icon
	"Elegant puzzle piece with shark pattern, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Puzzle mechanic art: Smart shark-routing challenges, for store display",
		"Level showcase: Beautiful puzzle environments with shark elements",
		"Solution preview: Satisfying puzzle-solving moments"
	],
	# Video subjects - Commercial Trailers
	[
		"Mechanics trailer: Core puzzle concepts and unique features",
		"Level showcase: Progressive difficulty and puzzle variety",
		"Content update: New puzzle types and challenges"
	]
)

static var RACING := GameGenre.new(
	Id.RACING,
	"Racing",
	"Games focused on vehicle-based competition and racing...",
	["Forza Horizon 5", "Gran Turismo 7", "F1 23", "Need for Speed Unbound", "Mario Kart 8 Deluxe"],
	# Icon subject - Store icon
	"Racing ship with speed lines and shark wake, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Ship roster: Diverse racing vessels with shark-proof modifications",
		"Track reveal: Spectacular race courses with shark hazards",
		"Championship art: Epic racing moment with multiple ships"
	],
	# Video subjects - Commercial Trailers
	[
		"Ship showcase: Racing vessel features and customization",
		"Track preview: Dynamic courses and environmental hazards",
		"Championship trailer: Professional racing and competition"
	]
)

static var RHYTHM := GameGenre.new(
	Id.RHYTHM,
	"Rhythm",
	"Music-based games requiring players to match rhythms and patterns...",
	["Beat Saber", "Rhythm Heaven", "Osu!", "Just Dance 2024", "Guitar Hero"],
	# Icon subject - Store icon
	"Musical shark fin with rhythm notes, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Rhythm action: Synchronized shark-dodging to sea shanties",
		"Song list reveal: Musical track selection with difficulty ratings",
		"Multiplayer spread: Coordinated crew rhythm performance"
	],
	# Video subjects - Commercial Trailers
	[
		"Gameplay trailer: Music-synced action with sea shanties",
		"Song pack reveal: New music content and features",
		"Multiplayer showcase: Cooperative rhythm challenges"
	]
)

static var RPG := GameGenre.new(
	Id.RPG,
	"RPG",
	"Story-driven games focusing on character development and progression. Features deep narrative, character customization, and complex combat systems. Players create and develop characters, engage in rich storylines with choice-driven narratives, and participate in strategic combat encounters.",
	["Baldur's Gate 3", "Final Fantasy XVI", "The Witcher 3", "Persona 5 Royal", "Dragon Age: Origins"],
	# Icon subject - Store icon
	"Pirate hero portrait with legendary shark-scale armor, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Party composition: Warrior, navigator, and mystic pirates facing elder shark",
		"Class roster: Four pirate specializations with unique shark-hunting abilities",
		"Story scene: Pirate council negotiating with intelligent shark leaders"
	],
	# Video subjects - Commercial Trailers
	[
		"Character creation and class selection with shark-based abilities",
		"Party-based combat showing tactical battles against shark bosses",
		"Story choices affecting pirate-shark faction relations"
	],
	["icon_1.png", "icon_2.png", "icon_3.png"],
	["image_1.png", "image_2.png", "image_3.png"],
	["video_1.ogv"]
)

static var SPORTS := GameGenre.new(
	Id.SPORTS,
	"Sports",
	"Games simulating various sports with realistic rules and mechanics...",
	["EA Sports FC **", "NBA *K**", "FIFA 23", "Madden NFL 24", "MLB The Show 23"],
	# Icon subject - Store icon
	"Sports trophy with shark motif, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Tournament art: Professional shark-surfing competition",
		"Team lineup: Competitive pirate teams in shark polo",
		"Championship moment: Victory celebration in shark stadium"
	],
	# Video subjects - Commercial Trailers
	[
		"Season trailer: New sports modes and features",
		"Tournament trailer: Professional competition highlights",
		"Team showcase: Player roster and statistics"
	]
)

static var STRATEGY := GameGenre.new(
	Id.STRATEGY,
	"Strategy",
	"Games focusing on tactical warfare and resource management...",
	["StarCraft II", "Age of Empires IV", "Civilization VI", "Total War: Warhammer III", "Company of Heroes 3"],
	# Icon subject - Store icon
	"Strategic map with ship and shark tokens, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Battle overview: Large-scale naval combat with shark units",
		"Tech tree reveal: Ship upgrades and shark countermeasures",
		"Resource management: Strategic port development system"
	],
	# Video subjects - Commercial Trailers
	[
		"Gameplay deep dive: Strategic mechanics and systems",
		"Faction showcase: Different pirate clans and shark types",
		"Campaign trailer: Story-driven mission objectives"
	]
)

static var SURVIVAL := GameGenre.new(
	Id.SURVIVAL,
	"Survival",
	"Games focusing on resource management and survival in challenging environments...",
	["Valheim", "Rust", "Subnautica", "Don't Starve", "The Forest"],
	# Icon subject - Store icon
	"Survival tools with shark warning emblem, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Survival systems: Resource gathering with shark threat meter",
		"Base building: Advanced shark defense constructions",
		"Crafting spread: Survival tool and weapon progression"
	],
	# Video subjects - Commercial Trailers
	[
		"Survival mechanics: Core gameplay systems showcase",
		"Base building: Construction and defense features",
		"Multiplayer trailer: Cooperative survival gameplay"
	]
)

static var VISUAL_NOVEL := GameGenre.new(
	Id.VISUAL_NOVEL,
	"Visual Novel",
	"Story-focused games emphasizing narrative and character relationships...",
	["Steins;Gate", "Doki Doki Literature Club", "Phoenix Wright: Ace Attorney", "Danganronpa", "VA-** Hall-A"],
	# Icon subject - Store icon
	"Story book with pirate and shark emblems, store-optimized",
	# Image subjects - Marketing Materials
	[
		"Character roster: Key pirate and shark-person cast members",
		"Story moment: Dramatic peace negotiations with shark kingdom",
		"Choice system: Branching narrative preview with consequences"
	],
	# Video subjects - Commercial Trailers
	[
		"Story trailer: Emotional narrative highlights",
		"Character reveal: Key cast member introductions",
		"Features showcase: Choice system and multiple endings"
	]
)

static var ALL_GENRES: Array[GameGenre] = [
	ARPG,
	BATTLE_ROYALE,
	CARD_GAME,
	CITY_BUILDER,
	FIGHTING,
	FPS,
	HORROR,
	LIFE_SIM,
	MOBA,
	OPEN_WORLD,
	PARTY_GAME,
	PLATFORM,
	PUZZLE,
	RACING,
	RHYTHM,
	RPG,
	SPORTS,
	STRATEGY,
	SURVIVAL,
	VISUAL_NOVEL
]

static var HISTORICAL_GENRES: Array[GameGenre] = [
	ARPG,            # Action RPGs like Diablo
	BATTLE_ROYALE,   # Battle Royale games like PUBG
	FPS,             # First Person Shooters like Counter-Strike
	MOBA,            # MOBAs like League of Legends
	OPEN_WORLD,      # Open World games like GTA
	PLATFORM,        # Platform games like Mario
	RACING,          # Racing games like Need for Speed
	RPG,             # Role Playing Games like Final Fantasy
	SPORTS,          # Sports games like FIFA
	SURVIVAL         # Survival games like Minecraft
]
