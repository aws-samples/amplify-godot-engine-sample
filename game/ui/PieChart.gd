@tool
class_name PieChart
extends Panel

signal animation_finished

@export_group("Data")
@export var values: Array[float] = []: set = _set_values
@export var colors: Array[Color] = []: set = _set_colors
@export var labels: Array[String] = []: set = _set_labels

@export_group("Layout")
@export_range(0.1, 1.0) var radius_scale: float = 0.8: set = _set_radius_scale
@export_range(0.1, 1.0) var label_radius_ratio: float = 0.6: set = _set_label_radius_ratio
@export_range(-360.0, 360.0) var start_angle_degrees: float = 0.0: set = _set_start_angle_degrees

@export_group("Rendering")
@export_range(32, 128, 8) var slice_points: int = 64: set = _set_slice_points

@export_group("Labels")
@export_enum("None", "Percentage Only", "Text Only", "Text + Percentage") var label_display_mode: int = 1: set = _set_label_display_mode
@export var label_separator: String = "\n": set = _set_label_separator
@export var value_format: String = "%.1f%%": set = _set_value_format

@export_group("Animation")
@export var animated: bool = true: set = _set_animated
@export_range(0.1, 5.0) var animation_duration: float = 1.0: set = _set_animation_duration

@export_group("Theme Overrides")
@export_subgroup("Colors")
@export var font_color: Color = Color.WHITE: set = _set_font_color
@export var font_shadow_color: Color = Color.BLACK: set = _set_font_shadow_color
@export var font_outline_color: Color = Color.BLACK: set = _set_font_outline_color

@export_subgroup("Constants")
@export var line_spacing: int = 3: set = _set_line_spacing
@export var outline_size: int = 0: set = _set_outline_size
@export var shadow_outline_size: int = 1: set = _set_shadow_outline_size
@export var shadow_offset_x: int = 0: set = _set_shadow_offset_x
@export var shadow_offset_y: int = 0: set = _set_shadow_offset_y

@export_subgroup("Fonts")
@export var font: Font = null: set = _set_font

@export_subgroup("Font Sizes")
@export var font_size: int = 16: set = _set_font_size

@export_subgroup("Styles")
@export var normal_style: StyleBox = null: set = _set_normal_style

# Internal variables
var _total_value: float = 0.0
var _radius: float
var _center: Vector2
var _animation_progress: float = 0.0
var _is_animating: bool = false

func start_animation() -> void:
	if animated:
		_is_animating = true
		_animation_progress = 0.0
	else:
		_animation_progress = 1.0
		_is_animating = false
		animation_finished.emit()
	queue_redraw()

func _init() -> void:
	custom_minimum_size = Vector2(200, 200)

func _ready() -> void:
	_update_dimensions()
	if animated:
		start_animation()
	else:
		_animation_progress = 1.0

func _draw() -> void:
	if values.is_empty() or colors.is_empty() or _total_value <= 0:
		return
	
	_draw_slices()

func _draw_slices() -> void:
	var current_angle = deg_to_rad(start_angle_degrees)
	var full_circle = TAU if not animated else TAU * _animation_progress
	
	for i in values.size():
		if i >= colors.size() or values[i] <= 0:
			continue
		
		var angle = (values[i] / _total_value) * TAU
		var remaining_angle = min(angle, full_circle - (current_angle - deg_to_rad(start_angle_degrees)))
		
		if remaining_angle <= 0:
			break
			
		_draw_slice(current_angle, current_angle + remaining_angle, colors[i])
		if label_display_mode != 0:
			_draw_label(values[i], current_angle, remaining_angle, i)
		
		current_angle += angle

func _draw_slice(p_start_angle: float, p_end_angle: float, p_color: Color) -> void:
	if p_end_angle < p_start_angle:
		p_end_angle += TAU
	
	var steps = max(4, int(slice_points * (p_end_angle - p_start_angle) / TAU))
	var points = PackedVector2Array()
	points.push_back(_center)
	
	for i in steps + 1:
		var angle = p_start_angle + i * (p_end_angle - p_start_angle) / steps
		points.push_back(_center + Vector2(cos(angle), sin(angle)) * _radius)
	
	draw_colored_polygon(points, p_color)

func _draw_label(p_value: float, p_angle: float, p_arc_angle: float, p_index: int) -> void:
	var percentage = (p_value / _total_value) * 100
	var percentage_text = value_format % percentage
	var label_text = ""
	var slice_label = labels[p_index] if p_index < labels.size() else ""
	
	match label_display_mode:
		1: # Percentage Only
			label_text = percentage_text
		2: # Text Only
			label_text = slice_label if not slice_label.is_empty() else percentage_text
		3: # Text + Percentage
			if slice_label.is_empty():
				label_text = percentage_text
			else:
				label_text = slice_label + label_separator + percentage_text
	
	var mid_angle = p_angle + p_arc_angle * 0.5
	var label_pos = _center + Vector2(cos(mid_angle), sin(mid_angle)) * _radius * label_radius_ratio
	var label_font = font if font != null else ThemeDB.fallback_font
	var text_size = label_font.get_string_size(label_text, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size)
	label_pos -= text_size * 0.5
	
	# Draw shadow if enabled
	if shadow_outline_size > 0:
		var shadow_pos = label_pos + Vector2(shadow_offset_x, shadow_offset_y)
		draw_string(label_font, shadow_pos, label_text, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, font_shadow_color)
	
	# Draw outline if enabled
	if outline_size > 0:
		for x in [-1, 0, 1]:
			for y in [-1, 0, 1]:
				if x == 0 and y == 0:
					continue
				var outline_pos = label_pos + Vector2(x, y) * outline_size
				draw_string(label_font, outline_pos, label_text, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, font_outline_color)
	
	# Draw main text
	draw_string(label_font, label_pos, label_text, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size, font_color)

func _process(delta: float) -> void:
	if _is_animating and animated:
		_animation_progress = min(_animation_progress + delta / animation_duration, 1.0)
		if _animation_progress >= 1.0:
			_is_animating = false
			animation_finished.emit()
		queue_redraw()

func _notification(what: int) -> void:
	match what:
		NOTIFICATION_RESIZED:
			_update_dimensions()

func _on_visibility_changed() -> void:
	if visible:
		if animated:
			start_animation()
		else:
			_animation_progress = 1.0
	else:
		_animation_progress = 1.0

func _update_dimensions() -> void:
	_center = size * 0.5
	_radius = min(size.x, size.y) * 0.5 * radius_scale
	queue_redraw()

func _calculate_total() -> void:
	_total_value = 0.0
	for value in values:
		_total_value += value if value > 0 else 0.0

# Property setters
func _set_values(p_values: Array[float]) -> void:
	values = p_values
	_calculate_total()
	queue_redraw()

func _set_colors(p_colors: Array[Color]) -> void:
	colors = p_colors
	queue_redraw()

func _set_labels(p_labels: Array[String]) -> void:
	labels = p_labels
	queue_redraw()

func _set_radius_scale(p_scale: float) -> void:
	radius_scale = p_scale
	_update_dimensions()

func _set_label_radius_ratio(p_ratio: float) -> void:
	label_radius_ratio = p_ratio
	queue_redraw()

func _set_start_angle_degrees(p_angle: float) -> void:
	start_angle_degrees = p_angle
	queue_redraw()

func _set_slice_points(p_points: int) -> void:
	slice_points = p_points
	queue_redraw()

func _set_label_display_mode(p_mode: int) -> void:
	label_display_mode = p_mode
	queue_redraw()

func _set_label_separator(p_separator: String) -> void:
	label_separator = p_separator
	queue_redraw()

func _set_value_format(p_format: String) -> void:
	value_format = p_format
	queue_redraw()

func _set_animated(p_animated: bool) -> void:
	animated = p_animated
	_animation_progress = 1.0 if not animated else 0.0
	_is_animating = animated
	queue_redraw()

func _set_animation_duration(p_duration: float) -> void:
	animation_duration = p_duration
	
# Theme setters
func _set_font_color(p_color: Color) -> void:
	font_color = p_color
	add_theme_color_override("font_color", p_color)
	queue_redraw()

func _set_font_shadow_color(p_color: Color) -> void:
	font_shadow_color = p_color
	add_theme_color_override("font_shadow_color", p_color)
	queue_redraw()

func _set_font_outline_color(p_color: Color) -> void:
	font_outline_color = p_color
	add_theme_color_override("font_outline_color", p_color)
	queue_redraw()

func _set_line_spacing(p_spacing: int) -> void:
	line_spacing = p_spacing
	add_theme_constant_override("line_spacing", p_spacing)
	queue_redraw()

func _set_outline_size(p_size: int) -> void:
	outline_size = p_size
	add_theme_constant_override("outline_size", p_size)
	queue_redraw()

func _set_shadow_outline_size(p_size: int) -> void:
	shadow_outline_size = p_size
	add_theme_constant_override("shadow_outline_size", p_size)
	queue_redraw()

func _set_shadow_offset_x(p_offset: int) -> void:
	shadow_offset_x = p_offset
	add_theme_constant_override("shadow_offset_x", p_offset)
	queue_redraw()

func _set_shadow_offset_y(p_offset: int) -> void:
	shadow_offset_y = p_offset
	add_theme_constant_override("shadow_offset_y", p_offset)
	queue_redraw()

func _set_font(p_font: Font) -> void:
	font = p_font
	add_theme_font_override("font", p_font)
	queue_redraw()

func _set_font_size(p_size: int) -> void:
	font_size = p_size
	add_theme_font_size_override("font_size", p_size)
	queue_redraw()

func _set_normal_style(p_style: StyleBox) -> void:
	normal_style = p_style
	add_theme_stylebox_override("normal", p_style)
	queue_redraw()
