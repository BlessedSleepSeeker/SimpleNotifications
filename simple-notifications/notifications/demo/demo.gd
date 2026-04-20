extends MarginContainer

@export var possible_titles: Array[String] = ["Seeker's Seeking Something !", "Stone Age", "Getting an Upgrade", "Acquire Hardware", "Suit Up", "Hot Stuff", "Isn't It Seeker Pick", "Diamonds!"]
@export var possible_texts: Array[String] = ["The heart and story of the addon ", "Mine Stone with your new Pickaxe", "Construct a better Pickaxe", "Smelt an Iron Ingot", "Protect yourself with a piece of iron armor", "Fill a Bucket with lava", "Upgrade your Code"]
@export var possible_icons: Array[Texture2D] = []
@export var possibles_sfx: Array[AudioStream] = []

@onready var amount_control: SpinBox = %AmountControl
@onready var spawn_control: OptionButton = %SpawnControl
@onready var lifetime_control: SpinBox = %LifetimeControl
@onready var icon_size: SpinBox = %IconSizeControl
@onready var label_size: SpinBox = %LabelSizeControl

@onready var doc_button: Button = %DocButton
@onready var hide_doc_button: Button = %HideDocButton
@onready var doc_container: PanelContainer = %DocumentationContainer

@onready var new_button: Button = %NewButton
@onready var stored_button: Button = %StoredButton
@onready var delayed_button: Button = %DelayedButton

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var total_notif_spawned: int = 0

signal focus_out

func _ready():
	amount_control.value = NotificationManager.maximum_notification_amount
	lifetime_control.value = NotificationManager.default_lifetime
	icon_size.value = NotificationManager.default_icon_size
	label_size.value = NotificationManager.default_labels_horizontal_size

	new_button.pressed.connect(_spawn_new_notification)
	stored_button.pressed.connect(_spawn_stored_notification)
	delayed_button.pressed.connect(_spawn_delayed_notification)

	amount_control.value_changed.connect(_on_amount_control_changed)
	spawn_control.item_selected.connect(_on_spawn_control_changed)
	lifetime_control.value_changed.connect(_on_lifetime_control_changed)
	icon_size.value_changed.connect(_on_icon_size_changed)
	label_size.value_changed.connect(_on_label_size_changed)

	doc_button.pressed.connect(_display_documentation)
	hide_doc_button.pressed.connect(_hide_documentation)

#region UI Settings

func _on_amount_control_changed(value: float) -> void:
	NotificationManager.maximum_notification_amount = int(value)

func _on_spawn_control_changed(index: int) -> void:
	match index:
		0:
			NotificationManager.spawn_point = NotificationManager_.SpawnPoints.TOP_LEFT
		1:
			NotificationManager.spawn_point = NotificationManager_.SpawnPoints.TOP_RIGHT
		2:
			NotificationManager.spawn_point = NotificationManager_.SpawnPoints.BOTTOM_RIGHT
		3:
			NotificationManager.spawn_point = NotificationManager_.SpawnPoints.BOTTOM_LEFT
		_:
			NotificationManager.spawn_point = NotificationManager_.SpawnPoints.TOP_LEFT

func _on_lifetime_control_changed(value: float) -> void:
	NotificationManager.default_lifetime = value

func _on_icon_size_changed(value: float) -> void:
	NotificationManager.default_icon_size = value

func _on_label_size_changed(value: float) -> void:
	NotificationManager.default_labels_horizontal_size = value

func _display_documentation() -> void:
	doc_container.show()

func _hide_documentation() -> void:
	doc_container.hide()

#endregion

#region Notifications creation
func get_randomized_notification() -> UserNotification:
	var notif: UserNotification = UserNotification.new()
	notif.title = possible_titles[rng.randi_range(0, possible_titles.size() - 1)]
	notif.text = possible_texts[rng.randi_range(0, possible_texts.size() - 1)]
	notif.icon = possible_icons[rng.randi_range(0, possible_icons.size() - 1)]
	notif.on_spawn_sfx = possibles_sfx[rng.randi_range(0, possibles_sfx.size() - 1)]

	return notif

func _spawn_new_notification() -> void:
	total_notif_spawned += 1
	var notif: UserNotification = get_randomized_notification()

	NotificationManager.push_notification(notif)

func _spawn_stored_notification() -> void:
	NotificationManager.push_stored_notification("additionals_pylons")

func _spawn_delayed_notification() -> void:
	if DisplayServer.window_is_focused():
		await focus_out
	var notif: UserNotification = get_randomized_notification()

	notif.title = "Your taskbar icon was [pulse freq=1.0 color=#FF9100CC ease=-2.0]blinking[/pulse] !"
	notif.text = "It should be gone now... Phew..."
	notif.lifetime = 0

	NotificationManager.push_notification(notif)

func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_OUT:
		focus_out.emit()
