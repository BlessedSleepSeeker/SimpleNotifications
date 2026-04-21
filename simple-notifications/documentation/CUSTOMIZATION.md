# Seeker's Simple Notifications - Customization

If you didn't, you should probably read [DOCUMENTATION.md](DOCUMENTATION.md) before !

- [Seeker's Simple Notifications - Customization](#seekers-simple-notifications---customization)
	- [Basic Customization - Theming](#basic-customization---theming)
	- [Medium Customization - Scene Modification](#medium-customization---scene-modification)
	- [Advanced Customization - Scene + Code](#advanced-customization---scene--code)

## Basic Customization - Theming

By default, `UserNotificationPanel` use a Theme (`res://ui/theme/notification_theme_base.tres`). You can either tweak this theme, or create others as you see fit.

## Medium Customization - Scene Modification

In addition to modifying a Theme, you can directly change the layout of the `UserNotificationPanel` scene ! Just open the scene at `res://ui/UserNotificationPanel.tscn` and change a few things around.

## Advanced Customization - Scene + Code

If you need more functionalities, create a copy of `UserNotificationPanel.tscn` and create a new script which inherits from `UserNotificationPanel.gd`. Make sure to set the new script to the Top Node of the copied scene !

You can now code the feature of your dream and custom everything as you see fit !