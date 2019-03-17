V.0.1.1 Handlers Push Notes

ACTIVITIES.LUA
- Removed any instances of the expNeeded calculation handlers.
- Removed any instances of the variable 'displayedExp'.

DUNGEON.LUA
- Made levelTestButton visible and functional for testing purposes. Updated how the buttons functionality works to better test.
- Removed any instances of the expNeeded calculation handlers.
- Removed any instances of the variable 'displayedExp'.

INVENTORY.LUA
- Removed any instances of the variable 'displayedExp'.
- Removed the Update() function that handled the expNeeded calculation.

LEVELUP.LUA
- Hardcoded button and text locations to handle overlapping better. There should no longer be an issue where the text every 4th level feeds under the buttons.
- Removed player level increase handler in the script.
- Removed unused variable 'isOn' as it broke how the functions fired.
- Removed some function calls that caused overlaps that fed over to next overlay show.
- Changed how buttons and text are displayed on load slightly.
- Removed a lot of unnecessary code located in the doOverlay() function.

MAIN.LUA
- Removed unused variables (loop, displayedExp)
- Gave 10 inspire potions and 1000 zoulds on first time load of game for testing purposes.
- Moved expNeeded calculation handler here. Modified the way the calculation is handled. Exists in the checkLevel() function

STATS.LUA
- Removed any instances of the expNeeded calculation handlers.
- Removed any instances of the variable 'displayedExp'. Replaced with the variable 'experience'.

