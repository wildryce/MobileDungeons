V.0.0.9 Push Update Notes

ACTIVITIES.LUA
- Setup didLevel variable (may be removed later, with current functionality). Currently disabled.
- Cleaned up code a bit.

DUNGEON.LUA
- Setup didLevel variable (may be removed later, with current functionality). Currently disabled.
- Added Inspiration Potion. This allows players to have a quick gain of experience.
- Balanced item finds a bit more. Before they were way too common.

GLOBALDATA.LUA
- Balanced some player variables. Players now start with less defense, and less stat points. This should help balance the gameplay a bit more, adding a little more threat.
- Added the Inspire Potion item.
- Removed duplicate and useless variables.

INN.LUA
- Re-did how scene-swap back to Tavern is handled. This should hopefully fix the random scene unload issue when any activity timers are active.

INVENTORY.LUA
- Added the Inspire Potion item.
- Added a button (and textbox) for item usage, primarily the new potion. if the player has enough, it will grant them experience and display how much they gained. If they do not have any potions then it lets them know they do not have.
- Changed the button listener to control both the leave and inspire potion buttons. It also acts as an update() function, only when a button is pressed (since that is the only time a variable here will update)

LEVELUP.LUA
- Fixed the sizing of the buttons. Instead of scaling based on screen size they now are hard-set.
- Started prep of didLevel variable. This will determine whether or not the player had a chance to choose their stats on each 4th level up. (This may be removed later do to functionality).

MAIN.LUA
- Removed useless variables from list.
- Added a safeguard function that checks if any variables are not set. If this were to happen then it will set it to the base variable. This will allow any future items to not cause the game to crash due to them not existing in the save prior.
- Changed how the pastTime is saved. It is now directly saved as a Variable and almost immediately saved to the savefile.
- Modified some variable readings to fix a read-error resulting in variables being read as 'nil'.
- Changed the handling of tavern and activities being loaded in to allow scene updates.

SHOP.LUA
- Added the Inspire Potion to the shop list.
- Modified the way the shop displays items. Instead of hardcoding variables in and having to select previous objects to determine current objects placement, there are now base variables that handle location and get updated after each item group iteration.
- Re-did how scene-swap back to Tavern is handled. This should hopefully fix the random scene unload issue when any activity timers are active.

/SPRITES FOLDER
- Added the Inspire Potion sprite

STATS.LUA
- Fixed a small issue regarding the calculation of experience needed until next level. It now gets calculated in this function as well as in others as a safeguard.

TAVERN.LUA
- Changed a couple lines of code.
 