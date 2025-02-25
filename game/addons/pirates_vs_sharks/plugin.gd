## Pirates vs Sharks plugin for Godot Engine.
##
## This plugin integrates Pirates vs Sharks Godot tools,
##
## @tutorial: https://github.com/aws-samples/aws-godot-engine-plugin
## @tutorial: https://github.com/aws-samples/aws-godot-engine/wiki
@tool
class_name PiratesVsSharksPlugin
extends EditorPlugin

## Name of the Pirates vs Sharks plugin.
const PIRATES_VS_SHARKS_PLUGIN_NAME = "Pirates vs Sharks"

## Icon for thePirates vs Sharks plugin.
const PIRATES_VS_SHARKS_PLUGIN_ICON: Texture2D = preload("res://addons/pirates_vs_sharks/plugin/icons/logo.svg")

## Home page URL for the AWS Amplify plugin.
const PIRATES_VS_SHARKS_PLUGIN_HOME: String = "https://github.com/aws-samples/aws-godot-engine-sample"

## Main panel
const MAIN_PANEL = preload("res://addons/pirates_vs_sharks/plugin/ui/Main.tscn")

var main_panel

## Called when the plugin enters the scene tree.
func _enter_tree() -> void:
	# Show the main panel
	main_panel = MAIN_PANEL.instantiate()
	EditorInterface.get_editor_main_screen().add_child(main_panel)
	_make_visible(false)
	
	# Display welcome message
	print("%s Plugin v%s (c) 2025-present Amazon, Inc" % [PIRATES_VS_SHARKS_PLUGIN_NAME, get_plugin_version()])
	print("Please visit %s!" % [PIRATES_VS_SHARKS_PLUGIN_HOME])

		
## Called when the plugin exits the scene tree.
func _exit_tree() -> void:
	# Hide the main panel
	if main_panel:
		main_panel.queue_free()

## Determines if the plugin has a main screen.
func _has_main_screen() -> bool:
	return true

## Show/Hide the main panel
func _make_visible(visible):
	if main_panel:
		main_panel.visible = visible

## Returns the name of the plugin.
func _get_plugin_name() -> String:
	return PIRATES_VS_SHARKS_PLUGIN_NAME

## Returns the icon for the plugin.
func _get_plugin_icon() -> Texture2D:
	return PIRATES_VS_SHARKS_PLUGIN_ICON
