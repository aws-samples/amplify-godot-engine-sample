@tool
extends EditorScript

func _run():
	
	print(Test.TEST)
	
	print("\n=== Generating Pirate Nationality Report ===\n")
	
	var regions = {
		"European": [],
		"Mediterranean": [],
		"Asian": [],
		"Indian Ocean": []
	}
	
	for nat in PirateNationality.ALL_NATIONALITIES.values():
		match nat.id:
			PirateNationality.Id.ENGLISH, \
			PirateNationality.Id.FRENCH, \
			PirateNationality.Id.DUTCH, \
			PirateNationality.Id.SPANISH, \
			PirateNationality.Id.PORTUGUESE:
				regions["European"].append(nat)
			
			PirateNationality.Id.OTTOMAN, \
			PirateNationality.Id.BARBARY, \
			PirateNationality.Id.GREEK, \
			PirateNationality.Id.VENETIAN:
				regions["Mediterranean"].append(nat)
			
			PirateNationality.Id.CHINESE, \
			PirateNationality.Id.JAPANESE, \
			PirateNationality.Id.MALAY, \
			PirateNationality.Id.BUGIS, \
			PirateNationality.Id.SULU:
				regions["Asian"].append(nat)
			
			PirateNationality.Id.GUJARATI, \
			PirateNationality.Id.MALABAR:
				regions["Indian Ocean"].append(nat)
	
	for region in regions:
		print("\n=== " + region + " Pirates ===\n")
		for nat in regions[region]:
			print_nationality(nat)

func print_nationality(nat: PirateNationality):
	print("--- " + nat.name + " ---")
	print("Notable Figures: " + str(nat.notable_figures.size()))
	
	var hex_colors = []
	for color in nat.colors:
		hex_colors.append(color.to_html(false))
	
	print("Colors: " + ", ".join(hex_colors))
	print("")
