@tool
class_name TypingRichTextLabel
extends RichTextLabel

# Configuration group
@export_group("Typing Settings")
## Speed at which characters appear (characters per second)
@export_range(1, 100, 1) var chars_per_second: float = 30.0
## Pause between sentences in auto mode (seconds)
@export_range(0.1, 10.0, 0.1) var auto_pause_time: float = 2.0
## Target text to be displayed with typing effect
@export_multiline var target_text: String = "":
	set(value):
		target_text = value
		if Engine.is_editor_hint():
			_preview_text()

# Preview group
@export_group("Preview")
## Enable live preview in editor
@export var preview_in_editor: bool = false:
	set(value):
		preview_in_editor = value
		if Engine.is_editor_hint():
			_preview_text()
## Test auto mode in editor
@export var test_auto_mode: bool = false:
	set(value):
		test_auto_mode = value
		if Engine.is_editor_hint() and value:
			type_text(target_text, true)

# Internal variables
var _sentences: Array = []
var _current_sentence_index: int = 0
var _current_length: int = 0 
var _display_timer: float = 0.0
var _pause_timer: float = 0.0
var _is_typing: bool = false
var _is_paused: bool = false
var _auto_mode: bool = false

# Signals
## Emitted when all sentences have been displayed
signal text_completed
## Emitted when a single sentence is completed
signal sentence_completed
## Emitted when typing starts
signal typing_started
## Emitted when a character is typed
signal char_typed(character: String)

func _ready():
	# Initialize with empty text
	text = ""
	if not Engine.is_editor_hint():
		# Initialize game text if provided
		if not target_text.is_empty():
			type_text(target_text)

func _process(delta):
	if Engine.is_editor_hint() and not preview_in_editor:
		return
		
	if _is_typing:
		_display_timer += delta
		
		# Calculate how many characters should be shown by now
		var target_chars = floor(_display_timer * chars_per_second)
		
		# If we need to show more characters
		while _current_length < target_chars and _current_length < _sentences[_current_sentence_index].length():
			# Add next character
			text = _sentences[_current_sentence_index].substr(0, _current_length + 1)
			char_typed.emit(_sentences[_current_sentence_index][_current_length])
			_current_length += 1
			
		# Check if we've finished displaying the current sentence
		if _current_length >= _sentences[_current_sentence_index].length():
			_is_typing = false
			sentence_completed.emit()
			if _auto_mode:
				_is_paused = true
				_pause_timer = 0.0
	
	# Handle auto mode pause between sentences
	elif _auto_mode and _is_paused:
		_pause_timer += delta
		if _pause_timer >= auto_pause_time:
			_is_paused = false
			if not next_sentence():
				# No more sentences, auto mode complete
				_auto_mode = false
				text_completed.emit()

# Start displaying text progressively 
func type_text(new_text: String, auto: bool = false) -> void:
	# Split text into sentences and store them
	_sentences = new_text.split(".", true) # true keeps empty strings
	# Remove empty sentences and trim whitespace
	_sentences = _sentences.filter(func(s): return s.strip_edges() != "")
	
	# Reset state
	_auto_mode = auto
	_current_sentence_index = 0
	_is_paused = false
	if not _sentences.is_empty():
		text = ""
		_current_length = 0
		_display_timer = 0.0
		_is_typing = true
		typing_started.emit()

# Move to next sentence if available
func next_sentence() -> bool:
	if _current_sentence_index + 1 < _sentences.size():
		_current_sentence_index += 1
		text = ""
		_current_length = 0
		_display_timer = 0.0
		_is_typing = true
		typing_started.emit()
		return true
	return false

# Skip the typing animation for current sentence
func skip_typing() -> void:
	if not _sentences.is_empty():
		text = _sentences[_current_sentence_index]
		_current_length = _sentences[_current_sentence_index].length()
		_is_typing = false
		sentence_completed.emit()
		if _auto_mode:
			_is_paused = true
			_pause_timer = 0.0

# Toggle auto mode on/off
func set_auto_mode(enabled: bool) -> void:
	_auto_mode = enabled
	if _auto_mode and not _is_typing and not _is_paused:
		# If we're not currently typing or paused, move to next sentence
		if not next_sentence():
			_auto_mode = false
			text_completed.emit()

# Stop auto mode
func stop_auto_mode() -> void:
	_auto_mode = false
	_is_paused = false

# Get whether the component is currently active (typing or paused)
func is_active() -> bool:
	return _is_typing or _is_paused

# Preview the text in the editor
func _preview_text() -> void:
	if Engine.is_editor_hint() and preview_in_editor:
		text = target_text
	else:
		text = ""

# Public getters for internal state
func is_typing() -> bool:
	return _is_typing

func is_paused() -> bool:
	return _is_paused

func is_auto_mode() -> bool:
	return _auto_mode

func get_current_sentence_index() -> int:
	return _current_sentence_index

func get_total_sentences() -> int:
	return _sentences.size()
