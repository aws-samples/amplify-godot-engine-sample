@tool
extends EditorScript

const GENERATED_NAMES := 5

func _run() -> void:
	print("\n=== Pirate Ship Name Generator ===\n")
	
	# Generate for each region
	for region in PirateRegion.ALL_REGIONS:
		print("\n=== Region: %s ===" % region.name)
		
		# Generate for each nationality in this region
		for nationality_id in region.nationalities:
			var nationality = PirateNationality.ALL_NATIONALITIES[nationality_id]
			print("\n--- Nationality: %s ---" % nationality.name)
			
			# Generate for each water type in this region
			for water_id in region.waters:
				var water = PirateWater.ALL_WATERS[water_id]
				print("\nWaters: %s" % water.name)
				
				# Generate multiple names for each combination
				for i in range(GENERATED_NAMES):
					var ship = PirateShipName.generate(nationality, water)
					print("  %d. %s" % [i + 1, ship.get_full_name()])
				
				print("\n" + "-".repeat(40))
			
			print("") # Empty line for readability

# Optional: Add these methods for more specific testing
func _generate_for_region(region: PirateRegion) -> void:
	print("\n=== Ships for %s Region ===" % region.name)
	
	for nationality_id in region.nationalities:
		var nationality = PirateNationality.ALL_NATIONALITIES[nationality_id]
		print("\n--- Nationality: %s ---" % nationality.name)
		
		for water_id in region.waters:
			var water = PirateWater.ALL_WATERS[water_id]
			print("\nWaters: %s" % water.name)
			
			for i in range(GENERATED_NAMES):
				var ship = PirateShipName.generate(nationality, water)
				print("  %d. %s" % [i + 1, ship.get_full_name()])
			
			print("\n" + "-".repeat(40))

func _generate_for_nationality(nationality: PirateNationality) -> void:
	print("\n=== Ships for %s Nationality ===" % nationality.name)
	
	for region in PirateRegion.ALL_REGIONS:
		if nationality.id in region.nationalities:
			print("\n--- Region: %s ---" % region.name)
			
			for water_id in region.waters:
				var water = PirateWater.ALL_WATERS[water_id]
				print("\nWaters: %s" % water.name)
				
				for i in range(GENERATED_NAMES):
					var ship = PirateShipName.generate(nationality, water)
					print("  %d. %s" % [i + 1, ship.get_full_name()])
				
				print("\n" + "-".repeat(40))

func _generate_for_water(water: PirateWater) -> void:
	print("\n=== Ships for %s Waters ===" % water.name)
	
	for region in PirateRegion.ALL_REGIONS:
		if water.id in region.waters:
			print("\n--- Region: %s ---" % region.name)
			
			for nationality_id in region.nationalities:
				var nationality = PirateNationality.ALL_NATIONALITIES[nationality_id]
				print("\n--- Nationality: %s ---" % nationality.name)
				
				for i in range(GENERATED_NAMES):
					var ship = PirateShipName.generate(nationality, water)
					print("  %d. %s" % [i + 1, ship.get_full_name()])
				
				print("\n" + "-".repeat(40))

func _generate_specific_combination(region: PirateRegion, nationality: PirateNationality, water: PirateWater) -> void:
	print("\n=== Ships for %s Region with %s Nationality in %s Waters ===" % [
		region.name, nationality.name, water.name
	])
	
	for i in range(GENERATED_NAMES):
		var ship = PirateShipName.generate(nationality, water)
		print("  %d. %s" % [i + 1, ship.get_full_name()])
	
	print("\n" + "-".repeat(40))
