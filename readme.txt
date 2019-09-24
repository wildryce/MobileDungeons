V.0.1.1 - Graphics UI Hotfix

Sprites Folder
+ Added settings.png for settings menu button (when implemented)

CHARACTERSELECTION.LUA
- Updated how the races buttons are displayed based on different screen ratios and sizes.
- Added FirstTimeLoad to selection to update that the player is done their character (user coud enter name, reset app and not have a race selected)

CREATECHARACTER.LUA
- Removed FirstTimeLoad updater variable to fix skipping of race selection

DUNGEON.LUA
- Disabled the levelTestButton (auto level-up button)

INN.LUA
- Changed zoulds currency symbol, updated buttons text to utilize it.
- Changed how buttons and heal log are displayed based on different screen ratios and sizes.
- Fixed title text to better display on different screen ratios, as it would cut off and merge into different objects.

MAIN.LUA
- Set players starting zoulds to 20
- Removed player starting with inspiration potions

SHOP.LUA
- Completed grid layout of shop items.
- Fixed Item count owned display updating issue
- Implemented zoulds currency symbol

TAVERN.LUA
- Implemented zoulds currency symbol