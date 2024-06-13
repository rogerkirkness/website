---
layout: post
title: Bloatware
date: September 2018
tags: [Technology]
book: false
---
I don't like that phones come with apps I don't want. The manufacturer and the OS providers know they are useless, so why do they include them? I found a way to safely remove unused apps from an Android phone, even the annoying ones that they don't let you delete, that won't destroy your phone (if you do it right) and works on any app. It only works if you delete stuff that isn't important, so research the name of the app before you do it and keep a backup.

1. Go to Settings > About > Tap "Build Number" 7 times.

2. Go to Developer Options > turn on 'USB Debugging'

3. Plug your phone into your computer via USB.

4. Open a terminal.

5. Download and install Android Debug Bridge.

6. Type `$ adb shell` to open a shell.

7. Type `$ pm list packages` to see all the apps.

8. Type `$ pm uninstall -k --user 0 (app_name)`

To do it, you need an Android phone. It needs to have USB debugging active and be plugged into your computer. And you need to download the ADB tool from the Android website. If you do those things as described, it will remove any app. It doesn't permanently delete them, but it hides it from the main user, which is close enough. If you somehow mess it up (like I did the first time, getting overzealous), hold the on button + volume up and recover the phone.
