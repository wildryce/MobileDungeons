V.0.0.7c Push Update Notes

ACTIVITIES.LUA
- Reworked countdowns to *hopefully* be affected by offline time

BACKTOGAME.LUA
- Added script to welcome the player back, with time elapsed, whether or not monster had fled and health regenerated.

GLOBALDATA.LUA
- Added welcomeEnabled variable to control the popup showing on game load. This will not affect until settings are implemented.

MAIN.LUA
- Created offline passage of time controller.
- Added popup controller to welcome back player.

NOTENOUGH.LUA
- Added script to control button presses. This allows the player to know that they do not have enough zoulds/items to buy/sell respectively.

SHOP.LUA
- Changed sizing of scrollview to fit screen fully now (minus UI overlaps).
- Reverted background to white.
- Removed previous controller functions for not having enough zoulds/items.

TAVERN.LUA
- Added a delete file button for debugging and testing purposes. This will be moved to the settings menu once implemented.