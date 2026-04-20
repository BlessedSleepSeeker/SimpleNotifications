@icon("uid://bcr0pufqu20o3")
extends PanelContainer
class_name UserNotificationPanel

@export var user_notification: UserNotification = null:
	set(value):
		user_notification = value
		build()

@onready var title_label: RichTextLabel = %Title
@onready var text_label: RichTextLabel = %Text
@onready var image_rect: TextureRect = %Image

@onready var timer: Timer = %FadeTimer
@onready var timer_bar: ProgressBar = %BarTimer

@onready var on_spawn_sfx_player: AudioStreamPlayer = %OnSpawnSFX

var spawn_tween: Tween = null
var fade_tween: Tween = null

signal clicked

func _ready() -> void:
	self.gui_input.connect(_on_input_received)
	build()

func build() -> void:
	apply_theme()
	apply_dimensions()
	apply_data()
	apply_timer()
	apply_sfx()
	apply_taskbar_blink()
	play_animation_spawn()

## Change the [Theme] used by the panel to [member UserNotification.applied_theme].
func apply_theme() -> void:
	if user_notification:
		self.theme = user_notification.applied_theme

## Set the custom minimum size of the controls to the decided values in [member UserNotification.labels_horizontal_size] & [member UserNotification.icon_size].
func apply_dimensions() -> void:
	if user_notification:
		if user_notification.labels_horizontal_size < 0:
			title_label.custom_minimum_size.x = 0
			text_label.custom_minimum_size.x = 0
			title_label.fit_content = true
			text_label.fit_content = true
		elif user_notification.labels_horizontal_size == 0:
			if NotificationManager.labels_horizontal_size < 0:
				title_label.custom_minimum_size.x = 0
				text_label.custom_minimum_size.x = 0
				title_label.fit_content = true
				text_label.fit_content = true
			else:
				title_label.custom_minimum_size.x = NotificationManager.labels_horizontal_size
				text_label.custom_minimum_size.x = NotificationManager.labels_horizontal_size
		else:
			title_label.custom_minimum_size.x = user_notification.labels_horizontal_size
			text_label.custom_minimum_size.x = user_notification.labels_horizontal_size
		
		if user_notification.icon_size < 0: ## Use the default icon size
			image_rect.custom_minimum_size = Vector2(0, 0)
			image_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
		elif user_notification.icon_size == 0: ## Use the default defined in [member NotificationManager.icon_size].
			if NotificationManager.icon_size < 0:
				image_rect.custom_minimum_size = Vector2(0, 0)
				image_rect.expand_mode = TextureRect.EXPAND_KEEP_SIZE
			else:
				image_rect.custom_minimum_size = Vector2(NotificationManager.icon_size, NotificationManager.icon_size)
		else: ## Override with custom values from [member UserNotification.icon_size]
			image_rect.custom_minimum_size = Vector2(user_notification.icon_size, user_notification.icon_size)

## Change the text in both labels according to [member UserNotification.title_rich_template] & [member UserNotification.text_rich_template].
## Change [member image_rect.texture] to [member UserNotification.icon].
func apply_data() -> void:
	if user_notification:
		title_label.text = user_notification.title_rich_template % user_notification.title
		text_label.text = user_notification.text_rich_template % user_notification.text
		image_rect.texture = user_notification.icon

## If [member UserNotification.lifetime] is more than zero, start a lifetime timer. The timer calls [method destroy] when it finishes.
func apply_timer() -> void:
	if user_notification && user_notification.lifetime >= 0:
		var lifetime: float = user_notification.lifetime if user_notification.lifetime > 0 else NotificationManager.lifetime
		timer.start(lifetime)
		timer.timeout.connect(play_animation_fade)
		timer_bar.max_value = lifetime

## If [member UserNotification.on_spawn_sfx] is not null, set it to [member on_spawn_sfx_player.stream] & start playing it.
func apply_sfx() -> void:
	if user_notification && user_notification.on_spawn_sfx:
		on_spawn_sfx_player.stream = user_notification.on_spawn_sfx
		on_spawn_sfx_player.play()

func destroy() -> void:
	self.queue_free()

func _on_input_received(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if user_notification:
			if user_notification.dismiss_on_click:
				clicked.emit()
				play_animation_fade()
		else:
			play_animation_fade()

func _process(_delta):
	if user_notification && not user_notification.disable_lifetime_animation && user_notification.lifetime >= 0:
		timer_bar.value = inverse_number_around_another(timer.time_left, timer.wait_time / 2)

func apply_taskbar_blink() -> void:
	if user_notification && user_notification.make_taskbar_icon_blink:
		DisplayServer.window_request_attention()

## Used to inverse [member Timer.time_left] around [member Timer.wait_time / 2] to make sure the progress value is from 0 to wait_time.
## inverse_number_around_another(2.3, 6) = 6 - (2.3 - 6) = 6 - -3.7 = 9.7.
static func inverse_number_around_another(number: float, axis: float) -> float:
	return axis - (number - axis)

#region Animations
## Play the spawn animation.
func play_animation_spawn() -> void:
	if not user_notification:
		return
	if user_notification.disable_animation_spawn:
		return
	self.modulate.a = 0
	spawn_tween = create_tween()
	if user_notification.use_default_values_spawn_animation:
		spawn_tween.tween_property(self, "modulate:a", 1, NotificationManager.tween_speed_spawn).set_trans(NotificationManager.tween_transition_spawn).set_ease(NotificationManager.tween_easing_spawn)
	else:
		spawn_tween.tween_property(self, "modulate:a", 1, user_notification.tween_speed_spawn).set_trans(user_notification.tween_transition_spawn).set_ease(user_notification.tween_easing_spawn)

## Play the spawn animation.
func play_animation_fade() -> void:
	if not user_notification:
		destroy()
		return
	if user_notification.disable_animation_fade:
		destroy()
		return
	if spawn_tween:
		if spawn_tween.is_running():
			spawn_tween.stop()
	fade_tween = create_tween()
	if user_notification.use_default_values_fade_animation:
		fade_tween.tween_property(self, "modulate:a", 0, NotificationManager.tween_speed_fade).set_trans(NotificationManager.tween_transition_fade).set_ease(NotificationManager.tween_easing_fade)
	else:
		fade_tween.tween_property(self, "modulate:a", 0, user_notification.tween_speed_fade).set_trans(user_notification.tween_transition_fade).set_ease(user_notification.tween_easing_fade)
	await fade_tween.finished
	destroy()

#endregion
