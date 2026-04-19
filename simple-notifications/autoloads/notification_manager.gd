extends CanvasLayer
class_name NotificationManager_

@export var notification_panel_scene: PackedScene = preload("uid://c2ydnuyrvo486")

## Maximum amount of displayed notification at the same time. If notifications are sent when the maximum is reached, they're put in a queue and displayed once space is available. Set to 0 to disable notifications and to -1 to allow infinite notifications.
@export var maximum_notification_amount: int = 4
## Time before a notification disapear.  
## Can be overriden on a per-notification basis. See [member Notification.lifetime].
@export var default_notification_lifetime: float = 10
## In which corner of the screen should the notification appear. See [enum SpawnPoints].[br]
## Can be overriden on a per-notification basis. See [member Notification.lifetime].
@export var spawn_point: SpawnPoints = SpawnPoints.BOTTOM_RIGHT

## Allow to prebuild and store notifications to be reused. Useful if you're going to send the same notification over and over again and dont want to build it every time.[br]
## See [method store_notification], [method push_stored_notification] and [method get_stored_notification].
@export var stored_notifications: Dictionary[String, UserNotification] = {}

@onready var top_left: MarginContainer = %TopLeft
@onready var top_right: MarginContainer = %TopRight
@onready var bottom_right: MarginContainer = %BottomRight
@onready var bottom_left: MarginContainer = %BottomLeft

var notifications_queue: Array[UserNotification] = []

## Enum used for notification spawnpoints.
enum SpawnPoints {
	TOP_LEFT,
	TOP_RIGHT,
	BOTTOM_RIGHT,
	BOTTOM_LEFT,
	USE_MANAGER_DEFAULT, ## Never set [member NotificationManager.spawn_point] to this, it will create an infinite loop.
}

func _ready():
	flush_all_notifications()

## Store a notification for future use. By default, the key is set to [member UserNotification.title].
func store_notification(user_notification: UserNotification) -> void:
	stored_notifications.set(user_notification.title, user_notification)

## Return a stored notification with [param notification_name] as key.
func get_stored_notification(notification_name: String) -> UserNotification:
	if stored_notifications.has(notification_name):
		return stored_notifications.get(notification_name)
	else:
		push_error("No Stored Notification with the name [%s] found." % notification_name)
		return null

## Push a stored notification to the notification queue.
func push_stored_notification(notification_name: String) -> void:
	push_notification(get_stored_notification(notification_name))

## Push a notification to the notification queue.
func push_notification(user_notification: UserNotification) -> void:
	if user_notification:
		notifications_queue.push_back(user_notification)
	try_to_display_notification()

func flush_all_notifications() -> void:
	for notif: UserNotification in get_tree().get_nodes_in_group("UserNotification") as Array[UserNotification]:
		notif.queue_free()
	notifications_queue = []

## Return the first notification in the queue.
func get_next_notification() -> UserNotification:
	return notifications_queue.front()

## Pop the first notification in the queue.
func pop_next_notification() -> UserNotification:
	return notifications_queue.pop_front()

func try_to_display_notification() -> void:
	if get_visible_notification_amount() >= maximum_notification_amount && maximum_notification_amount != -1:
		## Too much notifications ! Let's wait some of them die first.
		return

	var next_notification: UserNotification = pop_next_notification()
	if next_notification == null:
		## No new notifications !
		return
	var notif_panel: UserNotificationPanel = notification_panel_scene.instantiate()
	add_notification_to_spawn_point(notif_panel, next_notification.spawn_point)
	notif_panel.user_notification = next_notification
	notif_panel.tree_exited.connect(try_to_display_notification)

func get_visible_notification_amount() -> int:
	return get_tree().get_nodes_in_group("UserNotification").size()

## Call [method add_child] on the proper spawn point.
func add_notification_to_spawn_point(panel: UserNotificationPanel, _spawn_point: NotificationManager_.SpawnPoints) -> void:
	match spawn_point:
		SpawnPoints.USE_MANAGER_DEFAULT:
			add_notification_to_spawn_point(panel, self.spawn_point)
		SpawnPoints.TOP_LEFT:
			top_left.get_node("VBoxContainer").add_child(panel)
		SpawnPoints.TOP_RIGHT:
			top_right.get_node("VBoxContainer").add_child(panel)
		SpawnPoints.BOTTOM_RIGHT:
			bottom_right.get_node("VBoxContainer").add_child(panel)
		SpawnPoints.BOTTOM_LEFT:
			bottom_left.get_node("VBoxContainer").add_child(panel)
