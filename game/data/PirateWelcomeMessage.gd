@tool
extends RefCounted
class_name PirateWelcomeMessage

### STATIC METHODS ###
static func generate(region: PirateRegion, captain: PirateCaptainName, ship: PirateShipName, parrot: PirateParrotName) -> String:
	var message_parts := []
	
	# Get frequently used references
	var base = captain.get_base()
	
	# Basic greeting with captain's base name
	message_parts.append(_format_greeting(captain))
	
	# Title and epithet handling using captain's properties
	if captain.has_title() or captain.has_epithet():
		message_parts.append(_format_titles(captain))
	
	# Ship introduction using full name
	message_parts.append(_format_ship(ship))
	
	# Base reference if available
	if base:
		message_parts.append(_format_base(base, region))
	
	# Parrot introduction
	message_parts.append(_format_parrot(parrot))
	
	# Regional and nationality descriptions
	message_parts.append(_format_region_descriptions(region, captain, ship))
	
	# Conclusion based on context
	message_parts.append(_get_random_conclusion(region, captain))
	
	return "\n".join(message_parts)

static func _format_greeting(captain: PirateCaptainName) -> String:
	var base = captain.get_base()
	var template = _get_random_from_array(_TEMPLATES.greetings)
	var params = {
		"captain": captain.get_base_name(),
		"base": base.name if base else ""
	}
	return template.format(params)

static func _format_titles(captain: PirateCaptainName) -> String:
	var parts := []
	var base = captain.get_base()
	
	if captain.has_title():
		parts.append(_get_random_from_array(_TEMPLATES.title_introductions).format({
			"title": captain.title
		}))
	
	if captain.has_epithet():
		parts.append(_get_random_from_array(_TEMPLATES.epithet_additions).format({
			"epithet": captain.epithet,
			"base": base.name if base else ""
		}))
	
	return " ".join(parts)

static func _format_ship(ship: PirateShipName) -> String:
	return _get_random_from_array(_TEMPLATES.ship_introductions).format({
		"ship": ship.get_full_name(),
		"water": ship.water.name if ship.water else ""
	})

static func _format_base(base: PirateBase, region: PirateRegion) -> String:
	return _get_random_from_array(_TEMPLATES.base_introductions).format({
		"base": base.name,
		"region": region.name
	})

static func _format_parrot(parrot: PirateParrotName) -> String:
	return _get_random_from_array(_TEMPLATES.parrot_mentions).format({
		"parrot": parrot.get_full_name()
	})

static func _format_region_descriptions(region: PirateRegion, captain: PirateCaptainName, ship: PirateShipName) -> String:
	var parts := []
	
	# Region-specific descriptions
	if _TEMPLATES.region_descriptions.has(region.id):
		parts.append(_get_random_from_array(_TEMPLATES.region_descriptions[region.id]))
	
	# Nationality flavor if available
	if captain.nationality:
		var nat_id = captain.nationality.id
		if _TEMPLATES.nationality_flavor.has(nat_id):
			parts.append(_get_random_from_array(_TEMPLATES.nationality_flavor[nat_id]))
	
	return "\n".join(parts)

static func _get_random_conclusion(region: PirateRegion, captain: PirateCaptainName) -> String:
	var base = captain.get_base()
	
	# Try base-specific conclusion
	if base and randf() < 0.3:
		return _get_random_from_array(_TEMPLATES.base_conclusions).format({
			"base": base.name
		})
	
	# Try region-specific conclusion
	if randf() < 0.3:
		return _get_random_from_array(_TEMPLATES.region_conclusions).format({
			"region": region.name
		})
	
	# Default to general conclusion
	return _get_random_from_array(_TEMPLATES.conclusions)

static func _get_random_from_array(array: Array) -> String:
	return array[randi() % array.size()]

### CONSTANTS ###
const _TEMPLATES := {
	"greetings": [
		"Ahoy, {captain} of {base}!",
		"Welcome aboard, {captain}!",
		"Make way for {captain} of {base}!",
		"All hail the return of {captain}!",
		"The legendary {captain} graces our presence!",
		"Stand ready for {captain}'s return!",
		"{captain} arrives to claim these waters!"
	],
	
	"title_introductions": [
		"Known far and wide as {title}",
		"The one they call {title}",
		"Feared across the seas as {title}",
		"Renowned as {title}",
		"The legendary {title}"
	],
	
	"epithet_additions": [
		"and forever {epithet} of {base}",
		", {epithet} of legend",
		", rightfully known as {epithet}",
		", the one true {epithet}",
		", forever remembered as {epithet}"
	],
	
	"ship_introductions": [
		"Your vessel, the {ship}, rides the {water} with pride.",
		"The legendary {ship} awaits your command in these waters.",
		"The {ship} cuts through the {water} like a blade.",
		"The fearsome {ship} dominates the {water}.",
		"Your mighty {ship} rules these waters."
	],
	
	"base_introductions": [
		"From your stronghold in {base}, you command the {region}.",
		"{base}, your fortress in the {region}, stands ready.",
		"The banners of {base} fly proud over the {region}.",
		"Your domain of {base} controls these waters of the {region}.",
		"The legendary {base} remains your unassailable sanctuary in the {region}."
	],
	
	"parrot_mentions": [
		"Your loyal companion {parrot} watches from above.",
		"{parrot} circles overhead, ready for action.",
		"{parrot} maintains vigilant watch from the crow's nest.",
		"The wise {parrot} surveys your domain.",
		"Your trusted {parrot} announces your presence."
	],

	"region_descriptions": {
		PirateRegion.Id.CARIBBEAN_SEA: [
			"The Caribbean waters teem with Spanish treasure fleets.",
			"Rich merchant ships ply these crystal waters.",
			"The heart of piracy beckons with golden opportunities."
		],
		PirateRegion.Id.SPANISH_MAIN: [
			"The Spanish Main offers countless prizes.",
			"These colonial waters flow with New World riches.",
			"Spanish fortresses guard untold wealth here."
		],
		PirateRegion.Id.MEDITERRANEAN: [
			"Ancient trade routes cross these historic waters.",
			"These timeless seas hold the wealth of empires.",
			"The Mediterranean offers rich prizes to the bold."
		],
		PirateRegion.Id.NORTH_SEA: [
			"The cold northern waters hide rich merchant convoys.",
			"These fierce seas reward the bravest raiders.",
			"Dutch and English wealth flows through these waters."
		],
		PirateRegion.Id.SOUTH_CHINA_SEA: [
			"The South China Sea holds the riches of the East.",
			"Silk and spice flow through these ancient waters.",
			"These eastern waters promise untold wealth."
		],
		PirateRegion.Id.MALACCA_STRAIT: [
			"The Strait of Malacca funnels the wealth of nations.",
			"Every trading ship must brave these waters.",
			"The spice trade flows through this narrow sea."
		],
		PirateRegion.Id.BARBARY_COAST: [
			"The Barbary Coast offers rich Christian prizes.",
			"These waters have made corsairs into legends.",
			"Merchant ships fear these infamous shores."
		],
		PirateRegion.Id.GUINEA_COAST: [
			"The Gold Coast lives up to its wealthy name.",
			"Rich European traders crowd these waters.",
			"These African shores hold countless opportunities."
		],
		PirateRegion.Id.ARABIAN_SEA: [
			"The treasures of India sail these ancient waters.",
			"These seas connect the wealth of East and West.",
			"Mughal riches flow through these waters."
		],
		PirateRegion.Id.MADAGASCAR: [
			"These waters hide the richest prizes of the East Indies.",
			"Every trading nation must brave these seas.",
			"The perfect hunting ground for ambitious pirates."
		],
		PirateRegion.Id.SULU_SEA: [
			"The maze-like waters of the Sulu Sea hide many secrets.",
			"These islands provide perfect raiding grounds.",
			"Rich traders dare not sail these waters alone."
		],
		PirateRegion.Id.DUTCH_EAST_INDIES: [
			"The spice islands promise infinite wealth.",
			"Dutch trading ships crowd these rich waters.",
			"These seas hold the treasures of the East Indies."
		]
	},
	
	"nationality_flavor": {
		PirateNationality.Id.ENGLISH: [
			"Your English colors promise no quarter to Spanish prizes.",
			"The Royal Navy's lessons serve you well in these waters.",
			"These seas will learn to fear the English privateer's flag.",
			"British determination and seamanship guide your raids.",
			"Your English crew yearns for Spanish gold."
		],
		PirateNationality.Id.FRENCH: [
			"Your fleur-de-lis strikes terror in merchant hearts.",
			"French audacity and courage mark your raids.",
			"The traditions of French corsairs live in your actions.",
			"Your French crew's élan gives you the edge in battle.",
			"These waters will remember French boldness."
		],
		PirateNationality.Id.DUTCH: [
			"Dutch trading knowledge serves your raiding well.",
			"The precision of Dutch seamanship guides your attacks.",
			"Your Dutch crew knows these trading routes intimately.",
			"The spirit of the Sea Beggars lives in your raids.",
			"Dutch determination makes every raid successful."
		],
		PirateNationality.Id.SPANISH: [
			"Spanish pride guides your ship through these waters.",
			"Your knowledge of Spanish trade routes proves invaluable.",
			"These seas respect the Spanish style of warfare.",
			"Your Spanish crew fights with unmatched ferocity.",
			"The legacy of Spanish navigators aids your cause."
		],
		PirateNationality.Id.PORTUGUESE: [
			"Centuries of Portuguese seafaring guide your raids.",
			"Your crew's experience in these waters proves decisive.",
			"Portuguese navigation secrets serve you well.",
			"The legacy of Portuguese explorers aids your cause.",
			"Your Portuguese seamanship outmatches any prey."
		],
		PirateNationality.Id.OTTOMAN: [
			"Ottoman naval traditions make your raids unstoppable.",
			"Your crew's mastery of Mediterranean warfare proves deadly.",
			"The Sultan's enemies fear your approach.",
			"Turkish naval tactics give you the advantage.",
			"Your Ottoman gunners strike terror into all prey."
		],
		PirateNationality.Id.BARBARY: [
			"The feared Barbary corsair flag flies proudly.",
			"Your crew's mastery of coastal warfare proves decisive.",
			"These waters know and fear Barbary tactics.",
			"Christian ships flee at the sight of your flag.",
			"Your Barbary crew's reputation precedes you."
		],
		PirateNationality.Id.CHINESE: [
			"Ancient Chinese naval traditions guide your fleet.",
			"Your crew's knowledge of eastern waters proves invaluable.",
			"The dragon flag commands respect in these seas.",
			"Centuries of Chinese maritime wisdom aid your cause.",
			"Your Chinese junk fleet rules these waters."
		],
		PirateNationality.Id.JAPANESE: [
			"The way of the Wokou guides your raids.",
			"Your crew's samurai spirit strikes fear into enemies.",
			"These waters know the legend of Japanese pirates.",
			"Eastern and Western tactics blend in your attacks.",
			"Your Japanese crew's discipline wins every battle."
		],
		PirateNationality.Id.MALAY: [
			"Malay maritime knowledge makes your raids unstoppable.",
			"Your crew navigates these treacherous waters with ease.",
			"These islands know and fear Malay raiders.",
			"Generations of seafaring expertise guide your attacks.",
			"Your Malay crew's mastery of local waters proves deadly."
		],
		PirateNationality.Id.BUGIS: [
			"The feared Bugis maritime traditions serve you well.",
			"Your crew's mastery of island warfare proves decisive.",
			"These waters know the legend of Bugis raiders.",
			"Local knowledge makes your raids unstoppable.",
			"Your Bugis crew's reputation strikes terror in all who sail here."
		],
		PirateNationality.Id.SULU: [
			"The Sulu raiding traditions guide your attacks.",
			"Your crew's knowledge of these islands proves invaluable.",
			"These waters fear the approach of Sulu raiders.",
			"Generations of maritime prowess aid your cause.",
			"Your Sulu crew's swift attacks leave no escape."
		]
	},
	
	"base_conclusions": [
		"May {base} prosper under your protection!",
		"For the glory of {base}!",
		"Let {base} grow ever stronger!",
		"May your enemies never find safe harbor near {base}!",
		"For the honor and prosperity of {base}!"
	],
	
	"region_conclusions": [
		"May the {region} know and fear your name!",
		"Let your legend grow throughout the {region}!",
		"The {region} trembles at your approach!",
		"From the depths of the {region}, victory awaits!",
		"These waters of the {region} belong to you!"
	],
	
	"conclusions": [
		"May the winds favor your sails!",
		"Let fortune guide your journey!",
		"The seas await your command!",
		"Glory and plunder lie ahead!",
		"To adventure and riches!",
		"May your enemies tremble at your approach!",
		"Fortune favors the bold!",
		"The tide rises with your return!",
		"Let legends speak of your deeds!",
		"Your next prize awaits on the horizon!",
		"The seas themselves bow to your will!",
		"May your powder stay dry and your blade sharp!"
	]
}
