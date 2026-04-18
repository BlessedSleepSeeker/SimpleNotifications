extends MarginContainer

@export var possible_titles: Array[String] = ["Seeker's Seeking Something !", "Stone Age", "Getting an Upgrade", "Acquire Hardware", "Suit Up", "Hot Stuff", "Isn't It Seeker Pick", "Diamonds!"]
@export var possible_texts: Array[String] = ["The heart and story of the addon ", "Mine Stone with your new Pickaxe", "Construct a better Pickaxe", "Smelt an Iron Ingot", "Protect yourself with a piece of iron armor", "Fill a Bucket with lava", "Upgrade your Code"]
@export var possible_icons: Array[Texture2D] = []
@export var possibles_sfx: Array[AudioStream] = []

@onready var new_button: Button = %NewButton
@onready var stored_button: Button = %StoredButton

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()

var total_notif_spawned: int = 0

func _ready():
	new_button.pressed.connect(_spawn_new_notification)

func _spawn_new_notification() -> void:
	total_notif_spawned += 1
	var notif: UserNotification = UserNotification.new()
	notif.title = possible_titles[rng.randi_range(0, possible_titles.size() - 1)]
	notif.text = possible_texts[rng.randi_range(0, possible_texts.size() - 1)]
	notif.image = possible_icons[rng.randi_range(0, possible_icons.size() - 1)]
	notif.on_spawn_sfx = possibles_sfx[rng.randi_range(0, possibles_sfx.size() - 1)]
	notif.lifetime = 2

	NotificationManager.push_notification(notif)