@tool
extends EditorScript

const GENERATED_NAMES := 10

func _run() -> void:
	print("\n=== Pirate Parrot Name Generator ===\n")
	
	print("\n=== Standard Names ===")
	_generate_standard_names()
	
	print("\n=== Simple Names ===")
	_generate_simple_names()
	
	print("\n=== Quirky Names ===")
	_generate_quirky_names()
	
	print("\n=== Custom Combinations ===")
	_generate_custom_combinations()

func _generate_standard_names() -> void:
	for i in range(GENERATED_NAMES):
		var parrot = PirateParrotName.generate()
		print("%d. %s" % [i + 1, parrot.get_full_name()])

func _generate_simple_names() -> void:
	for i in range(GENERATED_NAMES):
		var parrot = PirateParrotName.generate_simple()
		print("%d. %s" % [i + 1, parrot.get_full_name()])

func _generate_quirky_names() -> void:
	for i in range(GENERATED_NAMES):
		var parrot = PirateParrotName.generate_quirky()
		print("%d. %s" % [i + 1, parrot.get_full_name()])

func _generate_custom_combinations() -> void:
	# No prefix, with title
	print("\n--- No Prefix, With Title ---")
	for i in range(5):
		var parrot = PirateParrotName.generate(false, true, false)
		print("%d. %s" % [i + 1, parrot.get_full_name()])
	
	# With prefix, no title
	print("\n--- With Prefix, No Title ---")
	for i in range(5):
		var parrot = PirateParrotName.generate(true, false, false)
		print("%d. %s" % [i + 1, parrot.get_full_name()])
	
	# With prefix and quirk
	print("\n--- With Prefix and Quirk ---")
	for i in range(5):
		var parrot = PirateParrotName.generate(true, true, true)
		print("%d. %s" % [i + 1, parrot.get_full_name()])
