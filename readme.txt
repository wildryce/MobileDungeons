V.0.0.7a Push Update Notes

Did a lot of cleaning up removing a bunch of unneeded variables and such. Also made code a bit cleaner.

ACTIVITIES.LUA
- Fixed timer issue that would speed up the passage of time (temporary fix).
- TO WORK ON: Allow for timer to update properly on app relaunch.
- Added level up capabilities and handler.
- Removed some useless variables and calls.
- Added the possibility to find zoulds when foraging.

CREATECHARACTER.LUA
- Fixed typos.

DUNGEON.LUA
- Fixed reading errors on some variables. Still have to fix HP text updating on levelup.
- Fixed FIGHT button updating, allowing delay to process.
- Fixed a healing issue resulting in a decimal point when reviving.
- Updated how monsters will be found.
- Modified order of Update() function for better handling.
- Added pullVariables() function to handle levelUps.
- Updated speed of Update() function to 1 second.

INN.LUA
- Made inn.lua, All mechanics present.

INVENTORY.LUA
- Fixed typos.

LEVELUP.LUA
- Made levelUp.lua
- Most mechanics present. Some to still be tested (players choosing stats every 4th level).

MAIN.LUA
- Fixed typos
- Changed speed of saving of variables to file to 0.5 seconds
- Added some quality of life print variables (console/debug only) for testing purposes

SHOP.LUA
- Added shop.lua
- To be worked on later.

SPRITES FOLDER
- Added sprites folder.

STATS.LUA
- Fixed typos.

TAVERN.LUA
- Fixed typos.
- Added Inn Button functionality.
- Added Shop Button functionality.
- Updated swapScene() function to cut down on code (now has a single handler for all button presses).
- Fixed issue of zoulds not updating properly.