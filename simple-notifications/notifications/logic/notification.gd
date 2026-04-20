@icon("uid://bwahc6b5jylb2")
extends Resource
class_name UserNotification
## A resource representing a future notification to be displayed to the user. Must be sent to [NotificationManager] and added to a new [UserNotificationPanel] to do anything.

## The title displayed on the notification panel.
@export var title: String = ""
## The rich text string template used to apply string interpolation to [member title]. Make sure your template has exactly one [codeblock]%s[/codeblock] in it.
@export var title_rich_template: String = "[b]%s[/b]"
## The body text displayed on the notification.
@export var text: String = ""
## The rich text string template used to apply string interpolation to [member text]. Make sure your template has exactly one [codeblock]%s[/codeblock] in it.
@export var text_rich_template: String = "%s"

## The icon displayed on the notification panel.
@export var icon: Texture2D = preload("uid://bvii2115eqamx")
## The sound played when the notification arrives. Set to null to disable sound playing.
@export var on_spawn_sfx: AudioStream = null
## Change the corner where the notification will spawn.
@export var spawn_point: NotificationManager_.SpawnPoints = NotificationManager_.SpawnPoints.USE_MANAGER_DEFAULT

@export_group("Size")
## The Title & Text label horizontal size.[br]
## Set to a negative to let the labels grows with the text inside (horizontal size between multiples notifications might not be consistent anymore). Set to 0 to make it use the default value defined in [member NotificationManager.labels_horizontal_size].[br]
@export_range(-1, 3680, 1) var labels_horizontal_size: float = 0
## The size of the icon.[br]
##Set to a negative number to let the image have their original size. Set to 0 to make it use the default value defined in [member NotificationManager.icon_size].[br]
@export_range(-1, 3680, 1) var icon_size: float = 0

## The theme applied to the [UserNotificationPanel] created to display this notification. See [method UserNotificationPanel.apply_theme]
@export var applied_theme: Theme = preload("uid://ueyxjy0k7i1k")

@export_group("Lifetime")
## Duration (in seconds) before the animation fades away.[br]Set lifetime to a negative number to make it infinite/disable the lifetime. Set to 0 to make it use the default value defined in [member NotificationManager.lifetime][br]
## /!\ If you set lifetime to a negative & [member dismiss_on_click] to false, the user will have no way of making the animation disapear !/!\
@export var lifetime: float = 0
## Control if clicking on the notification make it go away. See [method UserNotificationPanel._on_input_received].
@export var dismiss_on_click: bool = true
## Disable lifetime progress display. See [method UserNotificationPanel._process].
@export var disable_lifetime_animation: bool = false

@export_group("Alerts")
## If true, make the taskbar icon blink if the game window is unfocussed when the notification is displayed. It's recommended to set [member lifetime] to 0 if you're using this, otherwise you might make the window blink but the player will come back to no notifications if they've expired.
@export var make_taskbar_icon_blink: bool = false

@export_category("Input Prompts Animations")

@export_group("Spawn")
## Use the values defined in [NotificationManager.disable_animation_spawn], [NotificationManager.tween_speed_spawn], [NotificationManager.tween_transition_spawn] & [NotificationManager.tween_easing_spawn], instead of their own.
@export var use_default_values_spawn_animation: bool = false
## Disable the animation played when displayed.
@export var disable_animation_spawn: bool = false
## Speed at which the animation is played.
@export var tween_speed_spawn: float = 0.2
## Change the [member Tween.TransitionType] applied to the tween.
@export var tween_transition_spawn: Tween.TransitionType = Tween.TRANS_LINEAR
## Change the easing applied to the tweens in the animation. Make sure to use this variable if you're doing a custom tween !
@export var tween_easing_spawn: Tween.EaseType = Tween.EASE_IN_OUT

@export_group("Fade")
## Use the values defined in [NotificationManager.disable_animation_fade], [NotificationManager.tween_speed_fade], [NotificationManager.tween_transition_fade] & [NotificationManager.tween_easing_fade], instead of their own.
@export var use_default_values_fade_animation: bool = false
## Disable the animation triggered when dismissed.
@export var disable_animation_fade: bool = false
## Speed at which the animation is played.
@export var tween_speed_fade: float = 0.2
## Change the [member Tween.TransitionType] applied to the tween.
@export var tween_transition_fade: Tween.TransitionType = Tween.TRANS_LINEAR
## Change the easing applied to the tweens in the animation. Make sure to use this variable if you're doing a custom tween !
@export var tween_easing_fade: Tween.EaseType = Tween.EASE_IN_OUT