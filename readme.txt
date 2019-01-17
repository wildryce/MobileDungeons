V.0.0.6 Push Update Notes

Did a lot of cleaning up removing a bunch of unneeded variables and such. Also made code a bit cleaner.

ACTIVITIES.LUA
- Updated how button clicks are handled
- Removed random print statements
- Added display log
- Added update function to allow variables to update on this scene
- Removed the removing of scenes
- Removed listener()
- Added item collection
- Changed use of activityTime to be boolean instead of base time
- Fixed Variable reading
- Added levelup() function to handle levelups [TO BUILD LATER ALONGSIDE dungeon.lua's]

CREATECHARACTER.LUA
- Fixed Variable reading

DUNGEON.LUA
- Updated how listener() function works in main.lua, only called once per creation of scene.
- Fixed Variable reading
- Removed the removing of scenes
- Sorted variables

GLOBALDATA.LUA
- Removed a lot of unnecessary variables.
- Updated some of the comments regarding variables function

INVENTORY.LUA
- Made inventory.lua
- Displays players inventory and updates whenever they collect any items

MAIN.LUA
- Updated Variables list to account for removal of variables from globaldata.lua
- Added listener() controller loop here [called from dungeon.lua], to always save data to file every 2 seconds.

STATS.LUA
- Fixed Variable reading
- Updated how the stats variable is handled

TAVERN.LUA
- Added inventory [chest] handler to open inventory.lua
- Removed unused variables regarding new button handler
- Added Zoulds count to tavern screen