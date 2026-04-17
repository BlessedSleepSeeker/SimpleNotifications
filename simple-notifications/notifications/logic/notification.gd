extends Resource
class_name UserNotification

@export var title: String = ""
@export var title_rich_template: String = "[b]%s[/b]"

@export var text: String = ""
@export var text_rich_template: String = "%s"

@export var image: Texture2D = preload("uid://bvii2115eqamx")

@export var spawn_point: NotificationManager.SpawnPoints = NotificationManager.SpawnPoints.USE_MANAGER_DEFAULT

@export_group("Size")
@export_range(1, 3680, 1) var labels_horizontal_size: float = 256
@export var image_x_size: float = 64
@export var image_y_size: float = 64

@export var notification_ui_theme: Theme = preload("uid://ueyxjy0k7i1k")

@export_group("Lifetime")
@export var lifetime: float = 10
@export var kill_on_click: bool = true
