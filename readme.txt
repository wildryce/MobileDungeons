V.0.0.8 Push Update Notes

ACTIVITIES.LUA
- Increased activity time from 20 seconds to 30 seconds.
- Collection log now scales how many items are displayed based on screen height. This means that it auto-clears the old collections when the threshhold is met.

BACKTOGAME.LUA
- Fixed some UI issues that caused the text to display outside of the box.
- The UI may be manually closed by clicking the "close" button or alternatively it will close after 10 seconds.

LEVELUP.LUA
- Fixed the mathematical equation that changed the Stats mods. They will now properly scale instead of giving decimal values.

MAIN.LUA
- Fixed some issues regarding offline passage of time. The game now saves the time properly.
- Fixed an issue where activity times were not saving and loading, instead setting back to zero. Times will now properly carry over with offine time.

NOTENOUGH.LUA
- Fixed an issue that resulted in the app crashing due to the overlay not properly temporarily disabling clicks on the store page.
- Changed the speed slightly at which the message appears. It now shows up for less time.