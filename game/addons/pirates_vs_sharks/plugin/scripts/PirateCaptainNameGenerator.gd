@tool
extends EditorScript

const GENERATED_NAMES := 5

func _run() -> void:
	print("\n=== Pirate Captain Name Generator ===\n")
	
	_generate_for_region(PirateRegion.CARIBBEAN_SEA)
	
	# Generate for each region
	for region in PirateRegion.ALL_REGIONS:
		print("\n=== Region: %s ===" % region.name)
		
		# Generate for each nationality in this region
		for nationality_id in region.nationalities:
			var nationality = PirateNationality.ALL_NATIONALITIES[nationality_id]
			print("\n--- Nationality: %s ---" % nationality.name)
			
			# Generate for each base in this region
			for base_id in region.bases:
				var base = PirateBase.ALL_BASES[base_id]
				print("\nBase: %s" % base.name)
				
				print("\nSimple Names:")
				for i in range(GENERATED_NAMES):
					var captain = PirateCaptainName.generate_simple(nationality, base)
					print("%d. %s" % [i + 1, captain.get_full_name()])
				
				print("\nRegular Names:")
				for i in range(GENERATED_NAMES):
					var captain = PirateCaptainName.generate(nationality, base)
					print("%d. %s" % [i + 1, captain.get_full_name()])
				
				print("\nFull Names:")
				for i in range(GENERATED_NAMES):
					var captain = PirateCaptainName.generate_full(nationality, base)
					print("%d. %s" % [i + 1, captain.get_full_name()])
				
				print("\n" + "-".repeat(40))
			
			print("") # Empty line for readability

# Optional: Add these methods for more specific testing
func _generate_for_region(region: PirateRegion) -> void:
	print("\n=== Captains for %s Region ===" % region.name)
	
	for nationality_id in region.nationalities:
		var nationality = PirateNationality.ALL_NATIONALITIES[nationality_id]
		print("\n--- Nationality: %s ---" % nationality.name)
		
		for base_id in region.bases:
			var base = PirateBase.ALL_BASES[base_id]
			print("\nBase: %s" % base.name)
			
			_generate_all_name_types(nationality, base)

func _generate_for_nationality(nationality: PirateNationality) -> void:
	print("\n=== Captains of %s Nationality ===" % nationality.name)
	
	for region in PirateRegion.ALL_REGIONS:
		if nationality.id in region.nationalities:
			print("\n--- Region: %s ---" % region.name)
			
			for base_id in region.bases:
				var base = PirateBase.ALL_BASES[base_id]
				print("\nBase: %s" % base.name)
				
				_generate_all_name_types(nationality, base)

func _generate_for_base(base: PirateBase) -> void:
	print("\n=== Captains from %s ===" % base.name)
	
	for region in PirateRegion.ALL_REGIONS:
		if base.id in region.bases:
			print("\n--- Region: %s ---" % region.name)
			
			for nationality_id in region.nationalities:
				var nationality = PirateNationality.ALL_NATIONALITIES[nationality_id]
				print("\n--- Nationality: %s ---" % nationality.name)
				
				_generate_all_name_types(nationality, base)

func _generate_all_name_types(nationality: PirateNationality, base: PirateBase) -> void:
	print("\nSimple Names:")
	for i in range(GENERATED_NAMES):
		var captain = PirateCaptainName.generate_simple(nationality, base)
		print("%d. %s" % [i + 1, captain.get_full_name()])
	
	print("\nRegular Names:")
	for i in range(GENERATED_NAMES):
		var captain = PirateCaptainName.generate(nationality, base)
		print("%d. %s" % [i + 1, captain.get_full_name()])
	
	print("\nFull Names:")
	for i in range(GENERATED_NAMES):
		var captain = PirateCaptainName.generate_full(nationality, base)
		print("%d. %s" % [i + 1, captain.get_full_name()])
	
	print("\n" + "-".repeat(40))
