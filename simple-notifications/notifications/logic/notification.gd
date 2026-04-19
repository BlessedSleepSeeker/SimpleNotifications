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

## The icon displayed on the notification.
@export var image: Texture2D = preload("uid://bvii2115eqamx")
## The sound played when the notification arrives. Set to null to disable sound playing.
@export var on_spawn_sfx: AudioStream = null
## Change the corner where the notification will spawn.
@export var spawn_point: NotificationManager_.SpawnPoints = NotificationManager_.SpawnPoints.USE_MANAGER_DEFAULT

@export_group("Size")
## The Title & Text label horizontal size. Make it bigger or smaller depending on your needs.
@export_range(1, 3680, 1) var labels_horizontal_size: float = 256
## The horizontal size applied to [member image].
@export var image_x_size: float = 64
## The vertical size applied to [member image].
@export var image_y_size: float = 64

## The theme applied to the [UserNotificationPanel] created to display this notification. See [method UserNotificationPanel.apply_theme]
@export var applied_theme: Theme = preload("uid://ueyxjy0k7i1k")

@export_group("Lifetime")
## Duration (in seconds) before the animation fades away.[br]Set lifetime to a negative number to make it infinite/disable the lifetime. Set to 0 to make it use the default value defined in [member NotificationManager.default_notification_lifetime][br]
## /!\ If you set lifetime to a negative & [member dismiss_on_click] to false, the user will have no way of making the animation disapear !/!\
@export var lifetime: float = 0
## Control if clicking on the notification make it go away. See [method UserNotificationPanel._on_input_received].
@export var dismiss_on_click: bool = true
## Disable lifetime progress display. See [method UserNotificationPanel._process].
@export var disable_lifetime_animation: bool = false

@export_group("Alerts")
## If true, make the taskbar icon blink if the game window is unfocussed when the notification is displayed. It's recommended to set [member lifetime] to 0 if you're using this, otherwise you might make the window blink but the player will come back to no notifications if they've expired.
@export var make_taskbar_icon_blink: bool = false
