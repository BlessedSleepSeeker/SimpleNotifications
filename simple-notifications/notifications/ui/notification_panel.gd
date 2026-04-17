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

signal clicked

func _ready() -> void:
	self.gui_input.connect(_on_input_received)
	if user_notification:
		build()

func build() -> void:
	apply_dimensions()
	apply_data()
	apply_timer()

func apply_dimensions() -> void:
	title_label.custom_minimum_size.x = user_notification.labels_horizontal_size
	text_label.custom_minimum_size.x = user_notification.labels_horizontal_size
	image_rect.custom_minimum_size = Vector2(user_notification.image_x_size, user_notification.image_y_size)

func apply_data() -> void:
	title_label.text = user_notification.title_rich_template % user_notification.title
	text_label.text = user_notification.text_rich_template % user_notification.text
	image_rect.texture = user_notification.image

func apply_timer() -> void:
	if user_notification.lifetime > 0:
		timer.start(user_notification.lifetime)
		timer.timeout.connect(destroy)

func destroy() -> void:
	self.queue_free()

func _on_input_received(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if user_notification:
			if user_notification.kill_on_click:
				clicked.emit()
				destroy()
		else:
			destroy()
		
	
