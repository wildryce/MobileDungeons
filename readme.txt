V.0.0.7b Push Update Notes

Did a lot of cleaning up removing a bunch of unneeded variables and such. Also made code a bit cleaner.

ACTIVITIES.LUA
- Removed unneeded lines of code and added some to fix display issues.
- Balanced collection count of items (somewhat).
- TO WORK ON: Allow for timer to update properly on app relaunch.

DUNGEON.LUA
- Possibly fixed an issue ofa creature dealing 0 damage.

GLOBALDATA.LUA
- Nothing game-changing, just spacing making a bit cleaner (most done before, just one line this time).

LEVELUP.LUA
- Fixed issue where upon reaching every 4th level, players stats/health would revert to base.
- Added a note that on app reset during stat increase choosing screen, they would lose the choice.

SHOP.LUA
- Added Scrollview for all shop items.
- Implemented base items in game currently with buy/sell mechanics completed.
- Implemented a fail-safe when player does not have enough zoulds/items to buy/sell.
- Removed listener function that served no purpose for shop functionality.

SPRITES FOLDER
- Added sprites for most items in game currently (and some future)