extends MarginContainer

@onready var new_button: Button = %NewButton
@onready var stored_button: Button = %StoredButton

var total_notif_spawned: int = 0

func _ready():
	new_button.pressed.connect(_spawn_new_notification)

func _spawn_new_notification() -> void:
	total_notif_spawned += 1
	var notif: UserNotification = UserNotification.new()
	notif.title = "Hellow World %d !" % total_notif_spawned
	notif.text = "Hello there !"
	notif.image = load("uid://cqidrtwvwhqk8")
	notif.lifetime = 2

	NotificationManager.push_notification(notif)