# ⚙ Seeker's Simple Notifications

⚙ Seeker's Simple Notifications is a modulable, open and robust Notification System for you to use in your Godot 4.6+ projects. Enjoy the peace of mind of a ready to use, fully commented and easily expandable addon ! 

The code is available on [Github](https://github.com/BlessedSleepSeeker/SimpleNotifications) and you can try a build online directly on [itch.io]() !

- [⚙ Seeker's Simple Notifications](#-seekers-simple-notifications)
	- [💻 Features](#-features)
	- [⚡ 4.6 \& 4.7 Animations](#-46--47-animations)
	- [🎯 Why should I use this ?](#-why-should-i-use-this-)
	- [🚀 Quick Start](#-quick-start)
	- [📝 License](#-license)
	- [📖 Included Documentation](#-included-documentation)
	- [💻 Requirements](#-requirements)
	- [🐛 Bug Reports](#-bug-reports)
	- [🔗Other Projects](#other-projects)

## 💻 Features

In short, you send notifications objects to an autoload that handles the UI.

**Global-level features :**

- Receive notifications and display them !
- You can set Project-Wide defaults values for all options,  and tune a specific notification to override theses defaults !
- Limit (or don't) the amount of simultaneous notifications on screen at the same time.
  - Notifications sent but not displayed are kept in a queue and are displayed once there's enough space !
  - Notifications can be dismissed by clicking or by letting them expire after a while. This create space for more !
- Store "named" notifications to invoke and reuse later !

**The Humble Notification :**

- Customize the Big Three of Achievements : Icon, Title, Description.
- Can play a sound on being displayed ! PYLONS !
- Control how and where (which corner) the notifications are displayed.
- Presets animations for spawn and fade.
- Display their remaining lifetime (can be disabled) thanks to a slick progress bar.
- Can make your actual taskbar icon blink! (but only if you want it too...)
- Super easy styling with Godot's Theming feature.

**Additional Stuff :**

- Playable demo scene
  - Never wonder how to integrate it into your game again. Just look at how I did it !
- Fully commented code for easier onboarding and learning.
  - Know what the classes are and do.
  - Know what the variables are and what they impact.
  - Know what the functions do and how they work.
- Many documentation files ! Check out Included Documentation below.

## ⚡ 4.6 & 4.7 Animations

The current animation is a simple fade in/out. It's really basic but does the job.

Godot 4.7 is coming soon and add a way to make complex UI animations in a super easy way. I will add more animations options to the pack once Godot 4.7 is here ! You can do them for 4.6 and under if you really need them for like tommorow, good luck and tell me how you did it !

4.6 Pack will of course stay available once 4.7 releases and I've made more animations.

## 🎯 Why should I use this ?

- 🔰 Godot beginners - Learn from clean, documented and organic code made with NO AI.
- 🕑 Game jam developers - Drop the presets in and be done with it !
- ♾ Professional developers - Want an extensible and customizable base for your notifications ? This is it.
- ⏭ Solodevs - Save hours of development time ! 

## 🚀 Quick Start

1. Open your project in Godot 4.6+
2. Add the Simple Notification's folder to your project.
3. Add NotificationManager as an autoload named NotificationManager.
4. You are ready to launch the demo scene and do your stuff !

## 📝 License

All the code is under the MIT license !

- ✅ Commercial use allowed - Use in free or paid games
- ✅ No attribution required - Credit appreciated but not mandatory
- ✅ Modify freely - Extend and customize as needed
- ✅ Share it however you want.

The added assets (sound effect, textures...) are not mine and are either from Starcraft or from Kenney.nl !

## 📖 Included Documentation

- README.md (this file !)

## 💻 Requirements

- Godot 4.6+ for the "Classic" version
- Godot 4.7+ for the "Fancy Animations" version

The version with sick animations is only available for Godot 4.7 (and will be available once Godot 4.7 will be released).

## 🐛 Bug Reports

If you ever encounter a bug or want to discuss the project, please put a comment on itch.io or message me on my Discord !

Also let me know if you're using this for your projects ! I'll add you to a collection on Itch :)

Thank you in advance !

## 🔗Other Projects

Check out my other Godot Addons !

- [Seeker's Splendid Settings](https://blessedsleepseeker.itch.io/splendid-settings) - A Complete Setting Framework with automatic UI generation
- [Seeker's Simple Input Prompts](https://blessedsleepseeker.itch.io/simple-inputs-prompts) - Customizable Input Prompts Nodes with many customization options !

You can now read the [Documentation](simple_notifications/documentation/DOCUMENTATION.md)
